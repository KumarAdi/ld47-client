package scenes;

import hxd.Key;
import hxd.Event;
import h2d.TextInput;
import h2d.Tile;
import h2d.Bitmap;
import haxe.Json;
import js.html.WebSocket;
import h2d.Scene;
import h2d.Text;
import scenes.UIManager;
import hxd.Res;

class GameLevel implements Level {
	public var scene:Scene;

	public var splash:Bitmap;


	private var boardManager:BoardManager;
	private var ws:WebSocket;
	private var uiManager:UIManager;

	private var gameID:Int;
	private var userID:Int;
	private var pk:String;
	private var charType:Int;
	private var userName:String;

	public function new() {
		this.scene = new Scene();
		scene.scaleMode = LetterBox(Config.boardWidth, Config.boardHeight);

		this.ws = new WebSocket("wss://ld47recoilapi.page/");

		this.boardManager = new BoardManager(ws);
		scene.addChild(this.boardManager.build());

		this.uiManager = new UIManager(ws);
        scene.addChild(this.uiManager.build());
	}

	public function init() {
		splash = new Bitmap(Tile.fromColor(Config.uiColor, Config.boardWidth, Config.boardHeight), scene);
		var font = Res.font.dirga.toFont();
		var splashText = new Text(font, splash);
        splashText.text = "Connecting...";
        splashText.setPosition((splash.tile.width / 2) - (splashText.calcTextWidth(splashText.text) / 2), (splash.tile.height / 2) - 10);

		this.ws.onopen = function() {
			trace("ws open");

            var entryBg = new Bitmap(Res.art.Title.toTile(), splash);
			entryBg.y = 0;

			splashText = new Text(font, splash);
            splashText.text = "Type your username:";
            splashText.setPosition((splash.tile.width / 2) - (splashText.calcTextWidth(splashText.text) / 2), (2 * splash.tile.height / 3));
	

            var nameEntry = new TextInput(font, splash);
			nameEntry.canEdit = true;
            nameEntry.text = "<Click to edit>";
            nameEntry.x = (splash.tile.width / 2) - 150;
			nameEntry.y = splashText.y + splashText.textHeight + 25;
			
			var alreadySent = false;

			nameEntry.onKeyDown = function(e:Event) {
				if (!alreadySent && e.keyCode == Key.ENTER) {
					ws.send(Json.stringify({
						type: "InitiateGame",
						username: nameEntry.text,
						character_type: 0
					}));

					alreadySent = true;

					// TEST CODE
					// ws.send(Json.stringify({
					// 	type: "Player",
					// 	id: 0,
					// 	game_id: 0,
					// 	charType: 0,
					// 	userName: nameEntry.text,
                    //     private_key: "Hi",
                    //     is_ai: false
					// }));

					// for (i in 0...10) {
					// 	ws.send(Json.stringify({
					// 		type: "PlayerJoin",
					// 		user_id: i,
					// 		username: nameEntry.text,
					// 		x: Std.int(Math.random() * 16),
					// 		y: Std.int(Math.random() * 9),
					// 		start_orientation: 0,
					// 		char_type: i % 3
					// 	}));
					// }
		
					// ws.send(Json.stringify({
					// 	type: "CardOptions",
					// 	card_options: [for (i in 0...3) Std.int(Math.random() * Config.cardList.length)]
					// }));
		
					// for (i in 1...10) {
					// 	ws.send(Json.stringify({
					// 		type: "Mutation",
					// 		user_id: i,
					// 		card_type: Config.cardList.length - 1,
					// 		card_location: 0,
					// 	}));
					// }
				}
			}

            var subtext = new Text(font, splash);
			subtext.y = nameEntry.y + nameEntry.textHeight + 20;
            subtext.text = "Press Enter to submit";
            subtext.x = (splash.tile.width / 2) - (subtext.calcTextWidth(subtext.text) / 2);
		};

		this.ws.onmessage = function(message) {
			trace(message.data);
			var data = Json.parse(message.data);
			switch (data.type) {
				case "Player":
					this.userID = data.id;
					this.gameID = data.game_id;
					this.charType = data.character_type;
					this.userName = data.username;
                    this.pk = data.private_key;
					uiManager.receiveGameInfo(this.userID, this.pk, this.gameID);
					boardManager.registerMyUser(this.userID, this.pk, this.gameID);
				case "PlayerJoin":
					boardManager.addCharacter(data.user_id, data.username, data.x, data.y, data.start_orientation, data.char_type);
				case "CardOptions":
					if (splash != null){
						trace("removing splash, setting to null");
						scene.removeChild(splash);
						splash = null;
					}
					boardManager.turnId = data.turn_id;
					uiManager.showCardChoices(data.turn_id, data.card_options);
				case "Mutation":
					var newProg = boardManager.updateProgram(data.user_id, data.card_type, data.card_location);
					if (newProg != null) {
						uiManager.drawProgram(newProg);
					}
				case "TillStart":
					if (splash != null){
						splashText.text = "Starting in: " + data.secs;
					}
				// case "ChooseCard": // TEST CODE
				// 	ws.send(Json.stringify({
				// 		type: "Mutation",
				// 		user_id: data.user_id,
				// 		card_type: data.card_number,
				// 		card_location: data.location,
				// 	}));
				case "PlayerDied":
					uiManager.toggleUI(false);
					var goScreen = boardManager.killPlayer(data.user_id);
					if (goScreen != null) {
						scene.addChild(goScreen);
					}
				default:
			}
        };
	}

	public function update(dt:Float):Null<Level> {
		boardManager.update(dt);
		uiManager.update(dt);
		return null;
	}
}
