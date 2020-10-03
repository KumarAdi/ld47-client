package scenes;

import hxd.Event;
import h2d.Interactive;
import hxd.Window;
import hxd.Key;
import h2d.Bitmap;
import h2d.Text;
import h2d.Object;

class BoardManager implements ComponentManager {
	var boardRoot:Object;

	public function new() {}

	public function build():Object {
		this.boardRoot = new Object();

		var tileImage = hxd.Res.art.tile.toTile();

		for (i in 0...Std.int(1920 / tileImage.width)) {
			for (j in 0...Std.int(1080 / tileImage.height)) {
				var tileSprite = new Bitmap(tileImage, boardRoot);
				tileSprite.setPosition(i * tileImage.width, j * tileImage.height);
			}
		}

		var boardSize = boardRoot.getBounds();
		var dragBoard = new Interactive(boardSize.width, boardSize.height, boardRoot);

        boardRoot.scale(0.5);
        
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
			});
		};

		dragBoard.onRelease = function(e:Event) {
            if (e.button != Key.MOUSE_RIGHT) {
                return;
            }
			dragBoard.stopDrag();
		}

		return boardRoot;
	}

	public function update(dt:Float) {}
}
