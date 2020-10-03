package scenes;

import h2d.TileGroup;
import h2d.Scene;
import h2d.Object;
import h2d.Bitmap;
import scenes.ComponentManager;
import Config;

class UIManager implements ComponentManager{

    private var uiMama: Object;

    public function new() {
        this.uiMama = new Object();

        var tempTile = h2d.Tile.fromColor(0xFF0000, Config.boardWidth, 200);
        var programBox = new Bitmap(tempTile, uiMama);
        programBox.y = Config.boardHeight - tempTile.height;

        var tempTile2 = h2d.Tile.fromColor(0xFF0000, 400, 800);
        var cardBox = new Bitmap(tempTile2, uiMama);
        cardBox.x = Config.boardWidth - tempTile2.width;
    }

    public function build(): Object {
        return uiMama;
    }

    public function update(dt: Float): Void {

        
    }

}