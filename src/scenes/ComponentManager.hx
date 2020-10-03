package scenes;

import h2d.Object;

interface ComponentManager {
    public function build(): Object;
    public function update(dt: Float): Void;
}