package scenes;

import h2d.Scene;
import h2d.Text;
import h2d.Font;    

class Menu implements Level {
    public var scene: Scene;

    public function new() {
        this.scene = new Scene();
        scene.scaleMode = LetterBox(1920, 1080);

        // Init map view button
        var font = hxd.res.DefaultFont.get();
        var title = new Text(font, scene);
        title.text = "Title";
        title.scale(10);
        title.x = scene.width/2 - title.textWidth/2;
        title.y = scene.height/3;
    }

    public function init() {}

    public function update(dt: Float): Null<Level> {
        return null;
    }

}