package scenes;

import h2d.TileGroup;
import h2d.Scene;
import h2d.Object;
import h2d.Bitmap;
import scenes.ComponentManager;
import Config;
import h2d.Text;

class UIManager implements ComponentManager{

    private var uiMama: Object;

    public function new() {
        this.uiMama = new Object();

        var tempTile = h2d.Tile.fromColor(0xFF0000, Config.boardWidth, 250);
        var programBox = new Bitmap(tempTile, uiMama);
        programBox.y = Config.boardHeight - tempTile.height;

        var tempTile2 = h2d.Tile.fromColor(0xFF0000, 500, 800);
        var cardBox = new Bitmap(tempTile2, uiMama);
        cardBox.x = Config.boardWidth - tempTile2.width;
    }

    public function showCardChoices(choices: Array<Int>) {
        var i = 1;
        for (choice in choices) {
            var font = hxd.res.DefaultFont.get();
            var cardName = new Text(font, uiMama);
            // set cardName.y to incremental heights in cardBox
            cardName.text = Config.cardList[choice].name;
            cardName.scale(10);
        }
    }

    public function build(): Object {
        return uiMama;
    }

    public function update(dt: Float): Void {

        
    }

}