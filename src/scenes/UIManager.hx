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
import h2d.Interactive;
import hxd.Key;
import hxd.Event;
import js.html.WebSocket;
import haxe.Json;

class UIManager implements ComponentManager{

    private var uiMama: Object;
    private var programBox: Bitmap;
    private var cardBox: Bitmap;
    private var dirgaFont: Font;
    private var stripeFont: Font;
    private var ws: WebSocket;
    private var program: Array<Bitmap>;
    private var programArea: Object;
    private var currentChoices: Array<Int>;
    private var selectedChoice: Int;
    private var choicesIcons: Array<Bitmap>;
    private var user_id: Int;
    private var pk: String;
    private var turn_id: Int;

    public function new(ws: WebSocket) {
        this.ws = ws;

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

        this.programArea = new Object(programBox);
        programArea.x = programBoxTitle.getBounds().width + 50;

        this.program = [];
        this.currentChoices = [];
        this.user_id = null;
        this.pk = null;
        this.turn_id = null;
    }

    public function showCardChoices(turn_id: Int, choices: Array<Int>) {
        // if (pk == null) {
        //     return;
        // }

        this.turn_id = turn_id;
        this.currentChoices = choices;
        choicesIcons = [];

        var i = 0;
        var optionSpacing = ((cardBox.getBounds().height - 200) / choices.length);

        for (choice in choices) {
            var optionHeight = optionSpacing * i + 200;
            var tileSize = Math.floor(3 * optionSpacing / 4);
            var tilePadding = Math.floor(tileSize / 3);
            var cardTile = Config.genCardList()[choice].img;
            var cardIcon = new Bitmap(cardTile, cardBox);
            cardIcon.setPosition(tilePadding, optionHeight);
            choicesIcons.push(cardIcon);

            var cardName = new Text(dirgaFont, cardBox);
            cardName.setPosition(cardIcon.x + cardIcon.getBounds().width + tilePadding, optionHeight + tilePadding);
            cardName.text = Config.genCardList()[choice].name;
            cardName.maxWidth = cardBox.tile.width - 45;

            // figure out spacing
            var programAreaWidth = programBox.tile.width - programArea.x;
            var singleCardSizeBasedOnWidth = Math.floor(programAreaWidth / (program.length + 1)) - 20; // 10px gutter
            var singleCardSizeBasedOnHeight = programBox.tile.height - 80; // 40px gutter
            var singleCardSize = Math.floor(Math.min(singleCardSizeBasedOnHeight, singleCardSizeBasedOnWidth));

            var cardListen = new h2d.Interactive(cardIcon.tile.width, cardIcon.tile.height, cardIcon);
            cardListen.onClick = function(e: Event) {
                var choiceId = choicesIcons.indexOf(cardIcon);
                
                trace(choiceId);
                cardListen.parent.scaleX = 0.9;
                cardListen.parent.scaleY = 0.9;

                this.selectedChoice = choiceId;
                ws.send(Json.stringify({
                    type: "ChooseCard",
                    card_number: this.selectedChoice, 
                    location: this.program.length, // currently always add to end 
                    user_id: this.user_id, 
                    pk: this.pk
                }));
            }

            i++;


            // ---- CARD DRAG UI, To be continued -----

            // cardListen.onPush = function(e:Event) {
            //     if (e.button != Key.MOUSE_LEFT) {
            //         e.cancel = true;
            //         return;
            //     }
            //     var x = e.relX;
            //     var y = e.relY;
            //     cardListen.startDrag(function(e:Event) {
            //         cardIcon.x += (e.relX - x);
            //         cardIcon.y += (e.relY - y);
            //         if (cardIcon.y > programBox.y) {
            //             var insertCardSmall = h2d.Tile.fromColor(Config.uiSecondary, 2, 2);
            //             var insertCardNormal = h2d.Tile.fromColor(Config.uiSecondary, singleCardSize, singleCardSize);
            //             var insertCardAnimation = new h2d.Anim([insertCardSmall, insertCardNormal], 15, programArea);
            //             insertCardAnimation.loop = false;
            //             if (cardIcon.x < program[0].x) {
            //                 insertCardAnimation.x = programAreaWidth + 10;
            //                 insertCardAnimation.y = 40;
            //             }
            //         }
            //     });
            // };
            // cardListen.onRelease = function(e:Event) {
            //     if (e.button != Key.MOUSE_LEFT) {
            //         return;
            //     }
            //     cardListen.stopDrag();
            // };
        }
    }

    public function receiveGameInfo(user_id: Int, pk: String): Void {
        this.user_id = user_id;
        this.pk = pk;
    }

    public function build(): Object {
        return uiMama;
    }

    public function update(dt: Float): Void {

        
    }

}