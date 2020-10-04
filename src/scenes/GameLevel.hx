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

class GameLevel implements Level {
	public var scene:Scene;

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

		this.ws = new WebSocket("wss://echo.websocket.org/");

		this.boardManager = new BoardManager();
		scene.addChild(this.boardManager.build());

		this.uiManager = new UIManager(ws);
        scene.addChild(this.uiManager.build());
	}

	public function init() {
		var splash = new Bitmap(Tile.fromColor(0x000000, Std.int(Config.boardWidth * 2 / 3), Std.int(Config.boardHeight * 2 / 3)), scene);
		splash.setPosition(Config.boardWidth / 4, Config.boardHeight / 4);
		var font = hxd.res.DefaultFont.get();
		font.resizeTo(20);
		var splashText = new Text(font, splash);

		splashText.text = "Connecting...";

		this.ws.onopen = function() {
			trace("ws open");
			splashText.text = "Enter your username:";

			var nameEntry = new TextInput(font, splash);
			nameEntry.canEdit = true;
			nameEntry.text = "<Username>";
			nameEntry.y = splashText.y + splashText.textHeight + 10;

			nameEntry.onKeyDown = function(e:Event) {
				if (e.keyCode == Key.ENTER) {
					ws.send(Json.stringify({
						type: "InitiateGame",
						username: nameEntry.text,
						character_type: 0
					}));
					scene.removeChild(splash);
				}
			}

			var subtext = new Text(font, splash);
			subtext.y = nameEntry.y + nameEntry.textHeight + 10;
			subtext.text = "Press Enter to submit";

			for (i in 0...10) {
				ws.send(Json.stringify({
					type: "PlayerJoin",
					user_id: i,
					username: "A",
					x: Std.int(Math.random() * Config.boardWidth / 120),
					y: Std.int(Math.random() * Config.boardWidth / 120),
					start_orientation: 0,
					character_type: 0
				}));
			}
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
                    uiManager.receiveGameInfo(this.userID, this.pk);
				case "PlayerJoin":
					boardManager.addCharacter(data.user_id, data.username, data.x, data.y, data.start_orientation, data.character_type);
				case "CardChoices":
					uiManager.showCardChoices(data.turn_id, data.card_choices);
				case "Mutation":
					boardManager.updateProgram(data.user_id, data.card_type, data.card_location);
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
