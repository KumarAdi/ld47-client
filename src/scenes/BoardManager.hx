package scenes;

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

typedef UserInfo = {username: String, program: Array<Int>, sprites: Map<Object, Anim>, orientation: Int, charType: Int}; 

class BoardManager implements ComponentManager {
	var boardRoot: Layers;
	private var users: Map<Int, UserInfo>;
	private var charRoots: Array<Object>;
	private var mutationsSeen: Set<Int>;
	private var numUsers: Int;


	public function new() {
		this.boardRoot = new Layers();
		this.users = new IntMap<UserInfo>();
		this.charRoots = [for (_ in 0...4) new Object()];
		this.mutationsSeen = new Set<Int>();
		this.numUsers = 0;
	}

	public function build():Object {
		var tileImage = hxd.Res.art.tile.toTile();

		var subBoards = [for (i in 0...4) new Layers()];
		for (subBoard in subBoards) {
			boardRoot.add(subBoard, 0);
		}

		for (x in 0...2) {
			for (y in 0...2) {
				var subBoard = subBoards[2*x + y];
				subBoard.setPosition(Config.boardWidth * x, Config.boardHeight * y);

				var tileRoot = new Object();
				subBoard.add(tileRoot, 0);

				for (i in 0...Std.int(Config.boardWidth / tileImage.width)) {
					for (j in 0...Std.int(Config.boardHeight / tileImage.height)) {
						var tileSprite = new Bitmap(tileImage, tileRoot);
						tileSprite.setPosition(i * tileImage.width, j * tileImage.height);

						var font = hxd.res.DefaultFont.get();
						var coord = new Text(font, tileSprite);
						coord.textColor = 0x000000;
						coord.text = '${i}, ${j}';
						coord.scale(2);
					}
				}
			}
		}

		boardRoot.ysort(0);

		for (i in 0...4) {
			subBoards[i].add(charRoots[i], 1);
		}

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

	public function updateProgram(userId: Int, cardType: Int, cardLocation: Int) {
		mutationsSeen.add(userId);
		if (cardType == -1) {
			this.users.get(userId).program.remove(cardLocation);
		} else {
			this.users.get(userId).program.insert(cardLocation, cardType);
		}
		if (mutationsSeen.size == this.numUsers) {
			trace('received all mutations');
			this.mutationsSeen = new Set<Int>();
			this.playAnimations(ExecutionEngine.run(this.users));
		}
	}

	public function addCharacter(userId: Int, username: String, x: Int, y: Int, dir: Int, charType: Int) {
		var baseSprites = [for (root in charRoots) new Object(root)];
		for (sprite in baseSprites) {
			sprite.x = x * 120;
			sprite.y = y * 120;
		}
		var sprites = [for (sprite in baseSprites) sprite => charInfoToAnim(charType, dir, sprite)];
		for (sprite in baseSprites) {
			var nameBox = new Text(Res.font.dirga.toFont(), sprite);
			nameBox.color = new Vector(0, 0 , 0);
			nameBox.text = username;
			nameBox.x = -60;
			nameBox.y = -(60 + nameBox.textHeight);
		}
		this.users.set(userId, {
			username: username,
			program: [],
			sprites: sprites,
			orientation: dir,
			charType: charType
		});
		numUsers = Lambda.count(users);
	}

	private function charInfoToAnim(charType: Int, rotation: Int, parent: Object): Anim {
		var animTile = Res.art.green.front_stand.toTile();
		switch [charType, rotation] {
			case [0, 0] | [0, 1]: animTile = Res.art.red.side_stand.toTile();
			case [0, 2]: animTile = Res.art.red.front_stand.toTile();
			case [0, 3]: animTile = Res.art.red.back_stand.toTile();
			case [1, 0] | [1, 1]: animTile = Res.art.green.side_stand.toTile();
			case [1, 2]: animTile = Res.art.green.front_stand.toTile();
			case [1, 3]: animTile = Res.art.green.back_stand.toTile();
			case [2, 0] | [2, 1]: animTile = Res.art.blue.side_stand.toTile();
			case [2, 2]: animTile = Res.art.blue.front_stand.toTile();
			case [2, 3]: animTile = Res.art.blue.back_stand.toTile();
			default:
		}

		var spriteSheet = animTile.gridFlatten(240);

		if (rotation == 1) {
			for (sprite in spriteSheet) sprite.flipX();
		}

		var ret = new Anim(spriteSheet, parent);
		ret.y = -120;
		ret.x = -60;
		return ret;
	}

	private function playAnimations(animations: Array<Array<{userId: Int, action: Int}>>) {
		playTic(animations, 0);
	}

	private function playTic(animations: Array<Array<{userId: Int, action: Int}>>, tic: Int): Void {
		var actionList = Config.genActionList();
		var steps = animations[tic];
		for (step in steps) {
			var actionData = actionList[step.action];
			var user = users.get(step.userId);
			var sprites = user.sprites;
			for (sprite in sprites) {
				sprite.loop = false;
				sprite.play(actionData.anim[user.charType]);
			}
		}
		
		if (tic < animations.length - 1) {
			Timer.delay(function() { playTic(animations, tic + 1); }, 1000);
		}
	}

	public function update(dt:Float) {}
}
