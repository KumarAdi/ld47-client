package scenes;

import h2d.Object;
import h2d.Scene;
import h2d.Text;
import scenes.UIManager;

class GameLevel implements Level {
    public var scene: Scene;
    private var boardManager: BoardManager;
    private var uiManager: UIManager;

    public function new() {
        this.scene = new Scene();
        scene.scaleMode = LetterBox(Config.boardWidth, Config.boardHeight);

        this.boardManager = new BoardManager();
        scene.addChild(this.boardManager.build());

        this.uiManager = new UIManager();
        scene.addChild(this.uiManager.build());
    }

    public function init() {}

    public function update(dt: Float): Null<Level> {
        boardManager.update(dt);
        uiManager.update(dt);
        return null;
    }
}