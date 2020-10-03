package scenes;

import h2d.TileGroup;
import h2d.Scene;
import h2d.Object;
import h2d.Bitmap;

class UIBuilder{

    private var UI: Object;

    public function new() {
        this.UI = new Object();
    }

    public function generateUI(): Object {
        // should there be a separation of phases between player drafting the cards, and viewing the program being executed?
        // maybe hide ui while actions are happening

        var tempTile = h2d.Tile.fromColor(0xFF0000, 1920, 200);
        var programBox = new Bitmap(tempTile, UI);
        programBox.y = 880;

        var tempTile2 = h2d.Tile.fromColor(0xFF0000, 400, 800);
        var cardBox = new Bitmap(tempTile2, UI);
        cardBox.x = 1520;

        return UI;
    }

}