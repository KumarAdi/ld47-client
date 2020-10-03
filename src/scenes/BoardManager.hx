package scenes;

import h2d.Text;
import h2d.Object;

class BoardManager implements ComponentManager {

    var boardRoot: Object;

    public function new() {

    }

    public function build(): Object {
        this.boardRoot = new Object();

        var font = hxd.res.DefaultFont.get();
        var title = new Text(font, boardRoot);
        title.text = "Board";
        title.scale(10);

        return boardRoot;
    }

    public function update(dt: Float) {}
}