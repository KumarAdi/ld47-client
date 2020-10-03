package scenes;

import h2d.TileGroup;
import h2d.Scene;
import h2d.Object;
import h2d.Bitmap;
import scenes.ComponentManager;
import Config;
import h2d.Text;
import hxd.Res;

class UIManager implements ComponentManager{

    private var uiMama: Object;
    private var programBox: Bitmap;
    private var cardBox: Bitmap;

    public function new() {
        this.uiMama = new Object();

        var tempTile = h2d.Tile.fromColor(Config.uiColor, Config.boardWidth, 250);
        this.programBox = new Bitmap(tempTile, uiMama);
        programBox.y = Config.boardHeight - tempTile.height;

        var tempTile2 = h2d.Tile.fromColor(Config.uiColor, 500, 800);
        this.cardBox = new Bitmap(tempTile2, uiMama);
        cardBox.x = Config.boardWidth - tempTile2.width;
    }

    public function showCardChoices(choices: Array<Int>) {
        var i = 0;
        for (choice in choices) {
            var cardName = new Text(Config.dirgaFont, cardBox);
            // set cardName.y to incremental heights in cardBox
            cardName.y = (cardBox.getBounds().height / choices.length) * i + 150;
            cardName.text = Config.cardList[choice].name;
            cardName.scale(10);
            i++;
        }
    }

    public function build(): Object {
        return uiMama;
    }

    public function update(dt: Float): Void {

        
    }

}