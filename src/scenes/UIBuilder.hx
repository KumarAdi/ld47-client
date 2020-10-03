package scenes;

import h2d.Scene;

class UIBuilder implements Level{

    public var scene: Scene;

    public function new() {
        this.scene = new Scene();
    }

    public function init() {
        
    }

    public function update(dt: Float): Null<Level> {
        return null;
    }

}