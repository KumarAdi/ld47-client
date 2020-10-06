package scenes;

import Config.MarkerType;
import haxe.ds.HashMap;
import h2d.col.IPoint;
import haxe.Json;
import js.html.WebSocket;
import motion.Actuate;
import h2d.Tile;
import Config.AnimType;
import h3d.Vector;
import haxe.Timer;
import js.lib.Set;
import h2d.Layers;
import hxd.Res;
import h2d.Anim;
import haxe.ds.IntMap;
import hxd.Event;
import h2d.Interactive;
import hxd.Window;
import hxd.Key;
import h2d.Bitmap;
import h2d.Text;
import h2d.Object;

typedef UserInfo = {username:String, program:Array<Int>, sprites:Map<Object, Anim>, orientation:Int, charType:Int, health:Int, healthText:Array<Text>};

class BoardManager implements ComponentManager {
	var boardRoot:Layers;
	private var users:Map<Int, UserInfo>;
	private var charRoots:Array<Layers>;
	private var mutationsSeen:Set<Int>;
	private var numUsers:Int;
	private var myUserId:Int;
	private var pk:String;
	private var gameID:Int;
	private var ws:WebSocket;

	public var turnId:Int;

	private var locIndex:Map<String, Int>;
	private var amDead: Bool;

	public function new(ws:WebSocket) {
		this.boardRoot = new Layers();
		this.users = new IntMap<UserInfo>();
		this.charRoots = [for (_ in 0...4) new Layers()];
		this.mutationsSeen = new Set<Int>();
		this.numUsers = 0;
		this.ws = ws;
	}

	public function build():Object {
		var tileImage = hxd.Res.art.tile.toTile();

		for (x in 0...2) {
			for (y in 0...2) {
				var charRoot = charRoots[2 * x + y];
				charRoot.setPosition(Config.boardWidth * x, Config.boardHeight * y);
				boardRoot.add(charRoot, 1);

				var tileRoot = new Object(boardRoot);
				tileRoot.setPosition(Config.boardWidth * x, Config.boardHeight * y);
				boardRoot.add(tileRoot, 0);

				for (i in 0...Std.int(Config.boardWidth / tileImage.width)) {
					for (j in 0...Std.int(Config.boardHeight / tileImage.height)) {
						var tileSprite = new Bitmap(tileImage, tileRoot);
						tileSprite.setPosition(i * tileImage.width, j * tileImage.height);
					}
				}
			}
		}

		boardRoot.ysort(0);

		var boardSize = boardRoot.getBounds();
		var dragBoard = new Interactive(boardSize.width, boardSize.height, boardRoot);

		dragBoard.enableRightButton = true;

		dragBoard.onPush = function(e:Event) {
			if (e.button != Key.MOUSE_RIGHT) {
				e.cancel = true;
				return;
			}
			var x = e.relX;
			var y = e.relY;
			dragBoard.startDrag(function(e:Event) {
				boardRoot.x += (e.relX - x) * boardRoot.scaleX;
				boardRoot.y += (e.relY - y) * boardRoot.scaleY;
				while (boardRoot.x < -1 * Config.boardWidth * boardRoot.scaleX || boardRoot.x > 0) {
					boardRoot.x -= Config.boardWidth * boardRoot.x / Math.abs(boardRoot.x);
				}
				while (boardRoot.y < -1 * Config.boardHeight * boardRoot.scaleY || boardRoot.y > 0) {
					boardRoot.y -= Config.boardHeight * boardRoot.y / Math.abs(boardRoot.y);
				}
			});
		};

		dragBoard.onRelease = function(e:Event) {
			if (e.button != Key.MOUSE_RIGHT) {
				return;
			}
			dragBoard.stopDrag();
		}

		Window.getInstance().addEventTarget(function(evt:Event) {
			switch (evt.kind) {
				case EWheel:
					boardRoot.setScale(Math.max(1.0, boardRoot.scaleX - evt.wheelDelta));
				default:
			}
		});

		return boardRoot;
	}

	public function registerMyUser(userId:Int, pk:String, gameID:Int) {
		this.myUserId = userId;
		this.pk = pk;
		this.gameID = gameID;
	}

	public function updateProgram(userId:Int, cardType:Int, cardLocation:Int):Null<Array<Int>> {
		mutationsSeen.add(userId);
		if (cardType == -1) {
			this.users.get(userId).program.remove(cardLocation);
		} else {
			this.users.get(userId).program.insert(cardLocation, cardType);
		}
		trace("Mutations seen: " + mutationsSeen.size, "num Users: " + this.numUsers);
		if (mutationsSeen.size >= this.numUsers) {
			trace('received all mutations');
			this.mutationsSeen = new Set<Int>();
			this.playAnimations(ExecutionEngine.run(this.users));
		}

		if (userId == this.myUserId) {
			return users.get(userId).program;
		}

		return null;
	}

	public function addCharacter(userId:Int, username:String, x:Int, y:Int, dir:Int, charType:Int) {
		var baseSprites = [];
		for (root in charRoots) {
			var sprite = new Object();
			root.add(sprite, 0);
			baseSprites.push(sprite);
		}
		for (sprite in baseSprites) {
			sprite.x = x * 120;
			sprite.y = y * 120;
		}
		var sprites = [
			for (sprite in baseSprites)
				sprite => new Anim(charInfoToTiles(charType, dir, Stand), sprite)
		];

		for (sprite in sprites) {
			sprite.x = 60;
			sprite.y = 0;
		}

		for (sprite in baseSprites) {
			var nameBox = new Text(Res.font.pixel.toFont(), sprite);
			nameBox.color = new Vector(0, 0, 0);
			nameBox.text = username;
			nameBox.x = (sprite.getBounds().width / 3) - (nameBox.calcTextWidth(username) / 2);
			nameBox.y = -(45 + nameBox.textHeight);
			nameBox.letterSpacing = 0.7;
		}
		this.users.set(userId, {
			username: username,
			program: [],
			sprites: sprites,
			orientation: dir,
			charType: charType,
			health: 20,
			healthText: []
		});

		var font = Res.font.pixel.toFont();
		var userInfo = users.get(userId);
		for (sprite in sprites) {
			var hpText = new Text(font, sprite);
			hpText.text = "HP: " + userInfo.health;
			hpText.setPosition(-10, 40);
			userInfo.healthText.push(hpText);
		}

		for (charRoot in charRoots)
			charRoot.ysort(0);
		numUsers = Lambda.count(users);
	}

	private function charInfoToTiles(charType:Int, rotation:Int, type:AnimType):Array<Tile> {
		var tileArr = [
			[
				Res.art.red.side_stand.toTile(),
				Res.art.red.front_stand.toTile(),
				Res.art.red.side_stand.toTile(),
				Res.art.red.back_stand.toTile()
			],
			[
				Res.art.green.side_stand.toTile(),
				Res.art.green.front_stand.toTile(),
				Res.art.green.side_stand.toTile(),
				Res.art.green.back_stand.toTile()
			],
			[
				Res.art.blue.side_stand.toTile(),
				Res.art.blue.front_stand.toTile(),
				Res.art.blue.side_stand.toTile(),
				Res.art.blue.back_stand.toTile()
			]
		];

		switch (type) {
			case Walk:
				tileArr = [
					[
						Res.art.red.side_walk.toTile(),
						Res.art.red.front_walk.toTile(),
						Res.art.red.side_walk.toTile(),
						Res.art.red.back_walk.toTile()
					],
					[
						Res.art.green.side_walk.toTile(),
						Res.art.green.front_walk.toTile(),
						Res.art.green.side_walk.toTile(),
						Res.art.green.back_walk.toTile()
					],
					[
						Res.art.blue.side_walk.toTile(),
						Res.art.blue.front_walk.toTile(),
						Res.art.blue.side_walk.toTile(),
						Res.art.blue.back_walk.toTile()
					]
				];
			case Flex:
				tileArr = [
					[
						Res.art.red.side_flex.toTile(),
						Res.art.red.front_flex.toTile(),
						Res.art.red.side_flex.toTile(),
						Res.art.red.back_flex.toTile()
					],
					[
						Res.art.green.side_flex.toTile(),
						Res.art.green.front_flex.toTile(),
						Res.art.green.side_flex.toTile(),
						Res.art.green.back_flex.toTile()
					],
					[
						Res.art.blue.side_flex.toTile(),
						Res.art.blue.front_flex.toTile(),
						Res.art.blue.side_flex.toTile(),
						Res.art.blue.back_flex.toTile()
					]
				];
			default:
		}

		var animTile = tileArr[charType][rotation];
		var spriteSheet = [for (sprite in animTile.gridFlatten(240)) sprite.center()];

		if (rotation == 1) {
			for (sprite in spriteSheet) {
				sprite.flipX();
			}
		}

		return spriteSheet;
	}

	private function markerTypeToTiles(markerType:MarkerType) {
		var tile = Res.art.markers.slash.toTile();
		switch (markerType) {
			case Slash: tile = Res.art.markers.slash.toTile();
			case Bubble: tile = Res.art.markers.bubble.toTile();
			case Electricity: tile = Res.art.markers.electricity.toTile();
			case Fire: tile = Res.art.markers.fire.toTile();
			case Ice: tile = Res.art.markers.ice.toTile();
			case Music: tile = Res.art.markers.music.toTile();
			case MusicBig: tile = Res.art.markers.musicbig.toTile();
			case Punch: tile = Res.art.markers.punch.toTile();
			case Stab: tile = Res.art.markers.stab.toTile();
			case Whip: tile = Res.art.markers.whip.toTile();
			case WideSlash: tile = Res.art.markers.wideslash.toTile();
			case Wind: tile = Res.art.markers.wind.toTile();
		}
		return [for (sprite in tile.gridFlatten(240)) sprite.center()];
	}

	private function playAnimations(animations:Array<Map<Int, Int>>) {
		playTic(animations, 0);
	}

	private function playTic(animations:Array<Map<Int, Int>>, tic:Int):Void {
		var actionList = Config.genActionList();
		var steps = animations[tic];
		var destinations = [];
		var effects = [];
		for (userId in users.keys()) {
			var actionIdx = 0;
			if (steps.exists(userId)) {
				actionIdx = steps.get(userId);
			}
			var actionData = actionList[actionIdx];
			var user = users.get(userId);

			user.orientation += actionData.rotation;
			while (user.orientation < 0) {
				user.orientation += 4;
			}
			user.orientation %= 4;

			var baseSprite = user.sprites.keys().next();

			var dest = new IPoint(Std.int(baseSprite.x), Std.int(baseSprite.y));
			switch (user.orientation) {
				case 0:
					dest.x += 120 * actionData.moveDist;
				case 1:
					dest.y += 120 * actionData.moveDist;
				case 2:
					dest.x -= 120 * actionData.moveDist;
				case 3:
					dest.y -= 120 * actionData.moveDist;
			}
			destinations.push({user: userId, destination: dest, actionData: actionData});
		}

		var conflictingPlayers = findConflictingPlayers(destinations);

		while (conflictingPlayers.size > 0) {
			trace('${conflictingPlayers.size} conflicting players');
			for (i in 0...destinations.length) {
				var userId = destinations[i].user;
				if (conflictingPlayers.has(userId)) {
					var sprite = users.get(userId).sprites.keys().next();
					destinations[i] = {
						user: userId,
						destination: new IPoint(Std.int(sprite.x), Std.int(sprite.y)),
						actionData: destinations[i].actionData
					};
				}
			}
			conflictingPlayers = findConflictingPlayers(destinations);
		}

		for (dest in destinations) {
			var user = users.get(dest.user);
			var sprites = user.sprites;
			var actionData = dest.actionData;
			var firstBoard = true;
			for (spritePair in sprites.keyValueIterator()) {
				var sprite = spritePair.value;
				var baseSprite = spritePair.key;
				sprite.loop = false;
				sprite.play(charInfoToTiles(user.charType, user.orientation, actionData.anim));
				sprite.onAnimEnd = function() {
					sprite.play(charInfoToTiles(user.charType, user.orientation, Stand));
				};

				for (marker in actionData.markers) {
					var tiles = this.markerTypeToTiles(marker.marker);
					var effect = new Anim(tiles, baseSprite);
					effect.y = 120;
					effect.loop = false;
					effect.onAnimEnd = function() {
						effect.remove();
					}
					effects.push(effect);

					var markerPos = new IPoint(marker.x, marker.y);

					if (user.orientation % 2 != 0) { // facing vertical
						var tmp = markerPos.x;
						markerPos.x = markerPos.y;
						markerPos.y = tmp;
					}

					if (user.orientation % 3 != 0) { // horizontal flip
						markerPos.x *= -1;
					}

					markerPos.x *= 120;
					markerPos.y *= 120;

					effect.x += markerPos.x;
					effect.y += markerPos.y;

					markerPos.x += Std.int(baseSprite.x);
					markerPos.y += Std.int(baseSprite.y);

					var hitId = this.locIndex.get(markerPos.toString());

					if (firstBoard && this.locIndex.exists(markerPos.toString())) {
						this.users.get(hitId).health -= actionData.dmg;
						if (this.users.get(hitId).health <= 0) {
							this.ws.send(Json.stringify({
								type: "PollPlayerDied",
								self_id: this.myUserId,
								other_id: hitId,
								pk: this.pk,
								game_id: this.gameID,
								turn_id: this.turnId
							}));
						}
						displayHealth(hitId);
						trace("player Hit " + hitId);
					}
				}

				Actuate.tween(baseSprite, 0.5, dest.destination).onUpdate(function() {
					baseSprite.x = baseSprite.x;
					baseSprite.y = baseSprite.y;
				}).onComplete(function() {
					baseSprite.x %= Config.boardWidth;
					baseSprite.y %= Config.boardHeight;
				});
				firstBoard = false;
			}
		}

		if (tic < animations.length - 1) {
			Timer.delay(function() {
				playTic(animations, tic + 1);
			}, 1000);
		} else {
			ws.send(Json.stringify({
				type: "AnimationsDone",
				player_id: this.myUserId,
				pk: this.pk,
				game_id: this.gameID,
				turn_id: this.turnId
			}));
		}
	}

	public function killPlayer(userId:Int):Null<Object> {
		for (sprite in this.users.get(userId).sprites) {
			sprite.parent.remove();
		}
		this.numUsers--;

		if (userId == this.myUserId) {
			amDead = true;
		}

		if (this.numUsers <= 1) {
			var goScreen = new Bitmap(Res.art.Title.toTile());
			var font = Res.font.dirga.toFont();
			var splashText = new Text(font, goScreen);
			splashText.setPosition((goScreen.tile.width / 2) - (splashText.calcTextWidth(splashText.text) / 2), (2 * goScreen.tile.height / 3));
			splashText.text = "Game Over!";

			if (!amDead) {
				splashText.text = "You Win!";
			} else {
				splashText.text = "You Died!";
			}

			return goScreen;
		}

		return null;
	}

	private function displayHealth(userId:Int) {
		var userInfo = this.users.get(userId);
		for (i in 0...4) {
			userInfo.healthText[i].text = "HP: " + userInfo.health;
		}
	}

	private function findConflictingPlayers(destinations:Array<{user:Int, destination:IPoint, actionData:Dynamic}>) {
		var seen = new Map<String, Int>();
		var ret = new Set<Int>();
		for (dest in destinations) {
			if (seen.exists(dest.destination.toString())) {
				ret.add(seen.get(dest.destination.toString()));
				ret.add(dest.user);
			}
			seen.set(dest.destination.toString(), dest.user);
		}
		this.locIndex = seen;
		return ret;
	}

	public function update(dt:Float) {}
}
