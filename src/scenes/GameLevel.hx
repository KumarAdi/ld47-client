package scenes;

import haxe.Json;
import js.html.WebSocket;
import h2d.Scene;
import h2d.Text;
import scenes.UIManager;


class GameLevel implements Level {
    public var scene: Scene;
    private var boardManager: BoardManager;
    private var ws: WebSocket;
    private var uiManager: UIManager;

    public function new() {
        this.scene = new Scene();
        scene.scaleMode = LetterBox(Config.boardWidth, Config.boardHeight);

        this.boardManager = new BoardManager();
        scene.addChild(this.boardManager.build());
      
        this.uiManager = new UIManager();
        scene.addChild(this.uiManager.build());

        uiManager.showCardChoices([1,0,1]);

        this.ws = new WebSocket("wss://echo.websocket.org/");

        var signup = {
            type: "signup",
            username: "Adi",
            color: "green"
        };

        this.ws.onopen = function () {
            trace("ws open");
            this.ws.send(Json.stringify(signup));
        };

        this.ws.onmessage = function (message) {
            var resp = Json.parse(message.data);
            trace(resp.username);
        };
    }

    public function init() {}

    public function update(dt: Float): Null<Level> {
        boardManager.update(dt);
        uiManager.update(dt);
        return null;
    }
}