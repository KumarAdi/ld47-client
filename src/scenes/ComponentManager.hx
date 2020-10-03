package scenes;

import h2d.Object;

interface UIManager {
    public function build(): Object;
    public function update(dt:Float, rootObj: Object): Void;
}