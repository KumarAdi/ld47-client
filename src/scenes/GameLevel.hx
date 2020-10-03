package scenes;

import h2d.Object;
import h2d.Scene;
import h2d.Text;

class GameLevel implements Level {
    public var scene: Scene;
    private var boardManager: BoardManager;

    public function new() {
        this.scene = new Scene();
        scene.scaleMode = LetterBox(1920, 1080);

        this.boardManager = new BoardManager();
        scene.addChild(this.boardManager.build());
    }

    public function init() {}

    public function update(dt: Float): Null<Level> {
        boardManager.update(dt);
        return null;
    }
}