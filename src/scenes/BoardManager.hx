package scenes;

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

typedef UserInfo = {username: String, program: Array<Int>, sprites: Map<Object, Anim>}; 

class BoardManager implements ComponentManager {
	var boardRoot: Layers;
	private var users: Map<Int, UserInfo>;
	private var charRoots: Array<Object>;

	public function new() {
		this.boardRoot = new Layers();
		this.users = new IntMap<UserInfo>();
		this.charRoots = [for (_ in 0...4) new Object()];
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
					boardRoot.setScale(Math.max(1.0, boardRoot.scaleX + evt.wheelDelta));
				case _:
			}
		});

		return boardRoot;
	}

	public function addCharacter(userId: Int, username: String, x: Int, y: Int, dir: Int, charType: Int) {
		var baseSprites = [for (root in charRoots) new Object(root)];
		for (sprite in baseSprites) {
			sprite.x = x * 120;
			sprite.y = y * 120;
		}
		var sprites = [for (sprite in baseSprites) sprite => charInfoToAnim(charType, dir, sprite)];
		this.users.set(userId, {
			username: username,
			program: [],
			sprites: sprites
		});
	}

	private function charInfoToAnim(charType: Int, rotation: Int, parent: Object): Anim {
		var spriteSheet = Res.art.green.g_front_stand.toTile().gridFlatten(240);
		var ret = new Anim(spriteSheet, parent);
		ret.y = -120;
		ret.x = -60;
		return ret;
	}

	public function update(dt:Float) {}
}
