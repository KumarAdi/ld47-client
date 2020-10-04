package scenes;

import h2d.TileGroup;
import h2d.Scene;
import h2d.Object;
import h2d.Bitmap;
import scenes.ComponentManager;
import Config;
import h2d.Text;
import hxd.Res;
import h2d.Font;

class UIManager implements ComponentManager{

    private var uiMama: Object;
    private var programBox: Bitmap;
    private var cardBox: Bitmap;
    private var dirgaFont: Font;
    private var stripeFont: Font;

    public function new() {
        this.uiMama = new Object();

        var tempTile = h2d.Tile.fromColor(Config.uiColor, Config.boardWidth, 280);
        this.programBox = new Bitmap(tempTile, uiMama);
        programBox.y = Config.boardHeight - tempTile.height;

        var tempTile2 = h2d.Tile.fromColor(Config.uiColor, 500, 800);
        this.cardBox = new Bitmap(tempTile2, uiMama);
        cardBox.x = Config.boardWidth - tempTile2.width;

        this.dirgaFont = Res.font.dirga.toFont();
        this.stripeFont = Res.font.stripe.toFont();
        stripeFont.resizeTo(54);

        var cardBoxTitle = new Text(stripeFont, cardBox);
        cardBoxTitle.text = "Pick next instruction";
        cardBoxTitle.setPosition(45, 45);
        cardBoxTitle.maxWidth = cardBox.tile.width - 45;

        var programBoxTitle = new Text(stripeFont, programBox);
        programBoxTitle.text = "Program";
        programBoxTitle.setPosition(45,45);
    }

    public function showCardChoices(choices: Array<Int>) {
        var i = 0;
        var optionSpacing = ((cardBox.getBounds().height - 200) / choices.length);

        for (choice in choices) {
            var optionHeight = optionSpacing * i + 200;
            var tileSize = Math.floor(3 * optionSpacing / 4);
            var tilePadding = Math.floor(tileSize / 3);
            var cardTile = h2d.Tile.fromColor(Config.uiSecondary, tileSize, tileSize);
            var cardIcon = new Bitmap(cardTile, cardBox);
            cardIcon.setPosition(tilePadding, optionHeight);

            var cardName = new Text(dirgaFont, cardBox);
            // set cardName.y to incremental heights in cardBox
            
            cardName.setPosition(cardIcon.x + cardIcon.getBounds().width + tilePadding, optionHeight + tilePadding);
            cardName.text = Config.cardList[choice].name;
            i++;
        }
    }

    public function build(): Object {
        return uiMama;
    }

    public function update(dt: Float): Void {

        
    }

}