package scenes;

import motion.Actuate;
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
import h2d.Tile;
import h2d.Mask;
import haxe.Timer;

class UIManager implements ComponentManager{

    private var uiMama: Object;
    private var programBox: Bitmap;
    private var cardBox: Bitmap;
    private var dirgaFont: Font;
    private var stripeFont: Font;
    private var ws: WebSocket;
    private var program: Array<Bitmap>;
    private var programArea: Mask;
    private var currentChoices: Array<Int>;
    private var selectedChoice: Int;
    private var selectedChoiceIndex: Int;
    private var choicesIcons: Array<Bitmap>;
    private var user_id: Int;
    private var pk: String;
    private var game_id: Int;
    private var turn_id: Int;
    private var choiceLocked: Bool;

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
        programBoxTitle.setPosition(45,25);

        var loopTile = Res.art.loop.toTile();
        var loopBg = new Bitmap(loopTile, programBox);
        loopBg.x = programBoxTitle.getBounds().width + 170;
        loopBg.y = 80;

        this.programArea = new Mask(Math.floor(programBox.tile.width - programBoxTitle.getBounds().width), Math.floor(programBox.tile.height), programBox);
        programArea.x = programBoxTitle.getBounds().width + 50;

        this.program = [];
        this.currentChoices = [];
        this.user_id = null;
        this.pk = null;
        this.game_id = null;
        this.turn_id = null;
    }

    public function showCardChoices(turn_id: Int, choices: Array<Int>) {
        // if (pk == null) {
        //     return;
        // }

        toggleUI(true);

        this.turn_id = turn_id;
        this.currentChoices = choices;
        choicesIcons = [];
        this.selectedChoice = null;
        choiceLocked = false;

        var i = 0;
        var optionSpacing = ((cardBox.getBounds().height - 200) / choices.length);
        var toDeletes = [];

        for (choice in choices) {
            var optionHeight = optionSpacing * i + 200;
            var tileSize = Math.floor(3 * optionSpacing / 4);
            var tilePadding = Math.floor(tileSize / 3);
            var cardTile = this.getCardImage(Config.cardList[choice].name);
            var cardIcon = new Bitmap(cardTile, cardBox);
            cardIcon.setPosition(tilePadding, optionHeight);
            choicesIcons.push(cardIcon);

            var cardName = new Text(dirgaFont, cardBox);
            cardName.setPosition(cardIcon.x + cardIcon.getBounds().width + tilePadding - 20, optionHeight + tilePadding - 5);
            cardName.text = Config.cardList[choice].name;
            cardName.maxWidth = 200;

            toDeletes.push({name: cardName, icon: cardIcon});

            var cardListen = new h2d.Interactive(cardIcon.tile.width, cardIcon.tile.height, cardIcon);
            cardListen.onClick = function(e: Event) {
                var choiceId = choicesIcons.indexOf(cardIcon);

                // if (choiceId != selectedChoice) {
                //     if (selectedChoice != null) {
                //         choicesIcons[selectedChoice].
                //     }
                // }

                this.selectedChoice = choice;
                this.selectedChoiceIndex = choiceId;
                ws.send(Json.stringify({
                    type: "ChooseCard",
                    card_number: this.selectedChoice, 
                    location: this.program.length, // currently always add to end 
                    user_id: this.user_id, 
                    pk: this.pk,
                    game_id: this.game_id,
                    turn_id: this.turn_id
                }));
                choiceLocked = true;
                
                Timer.delay(function() {
                    for (toDelete in toDeletes) {
                        toDelete.name.remove();
                        toDelete.icon.remove();
                    }
                    this.toggleUI(false);
                }, 3000);
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

    private function getCardImage(cardName: String):Tile {
        var cardImg = Res.art.cards.move1; // default case
        switch (cardName) {
            case "Move 1":
                cardImg = Res.art.cards.move1;
            case "Move 2":
                cardImg = Res.art.cards.move2;
            case "Move 3":
                cardImg = Res.art.cards.move3;
            case "Reverse":
                cardImg = Res.art.cards.reverse;
            case "Turn Left":
                cardImg = Res.art.cards.turnleft;
            case "Turn Right":
                cardImg = Res.art.cards.turnright;
            case "U-Turn":
                cardImg = Res.art.cards.uturn;
            case "Act Erratically":
                cardImg = Res.art.cards.acterratically;
            case "Reposition":
                cardImg = Res.art.cards.reposition;
            default:
        }
        return cardImg.toTile();
    }

    public function drawProgram(newProg: Array<Int>): Void{
        programArea.removeChildren();

        // figure out spacing
        var singleCardSizeBasedOnWidth = Math.floor(programArea.width / (newProg.length + 1)) - 20; // 10px gutter
        var singleCardSizeBasedOnHeight = programBox.tile.height - 40; // 20px gutter
        var singleCardSize = Math.floor(Math.min(singleCardSizeBasedOnHeight, singleCardSizeBasedOnWidth));

        var i = 0;
        for (prog in newProg) {
            var progTile = this.getCardImage(Config.cardList[prog].name);
            var progIcon = new Bitmap(progTile, programArea);
            if (singleCardSize < progTile.width) {
                progIcon.scaleX = singleCardSize / progTile.width;
                progIcon.scaleY = singleCardSize / progTile.height;
            }
            progIcon.setPosition((programArea.width / 2) - ((singleCardSize * newProg.length) / 2) + singleCardSize * i + ((singleCardSize - progTile.width) / 2), ((programBox.tile.height - singleCardSize) / 2) + ((singleCardSize - progTile.height) / 2) - 35);
            i++;
        }
    }

    public function receiveGameInfo(user_id: Int, pk: String, game_id: Int): Void {
        this.user_id = user_id;
        this.pk = pk;
        this.game_id = game_id;
    }

    public function build(): Object {
        return uiMama;
    }

    public function toggleUI(toggle: Bool): Void {
        if (toggle) {
            Actuate.tween(cardBox, 1, {
                x: Config.boardWidth - cardBox.tile.width,
                y: 0
            }).onUpdate(function () {
                cardBox.x = cardBox.x;
                cardBox.y = cardBox.y;
            });
            Actuate.tween(programBox, 1, {
                x: 0,
                y: Config.boardHeight - programBox.tile.height
            }).onUpdate(function () {
                programBox.x = programBox.x;
                programBox.y = programBox.y;
            });
        } else {
            Actuate.tween(cardBox, 1, {
                x: Config.boardWidth,
                y: 0
            }).onUpdate(function () {
                cardBox.x = cardBox.x;
                cardBox.y = cardBox.y;
            });
            Actuate.tween(programBox, 1, {
                x: 0,
                y: Config.boardHeight - 100
            }).onUpdate(function () {
                programBox.x = programBox.x;
                programBox.y = programBox.y;
            });
        }
    }

    public function update(dt: Float): Void {}

}