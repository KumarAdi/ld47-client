package scenes;

import haxe.Json;
import js.html.WebSocket;
import h2d.Scene;

class GameLevel implements Level {
    public var scene: Scene;
    private var boardManager: BoardManager;
    private var ws: WebSocket;

    public function new() {
        this.scene = new Scene();
        scene.scaleMode = LetterBox(1920, 1080);

        this.boardManager = new BoardManager();
        scene.addChild(this.boardManager.build());

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
        return null;
    }
}