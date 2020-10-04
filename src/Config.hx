import h2d.Tile;
import hxd.Res;
import haxe.Json;

typedef CardData = {
	var name:String;
	var img:String;
	var disorient:Bool;
	var dmg:Int;
	var action:Array<Int>;
}

typedef ActionData = {
	var moveDist:Int;
	var rotation:Int;
	var anim:Array<Tile>;
}

class Config {
	public static final boardWidth = 1920;
	public static final boardHeight = 1080;

	public static final uiColor = 0x065e91;
	public static final uiSecondary = 0x063c5c;

	public static final cardList:Array<CardData> = [
		{
			name: "Move 1",
			img: "move1",
			disorient: false,
			dmg: 0,
			action: [0]
		},
		{
			name: "Discharge (disorient)",
			img: "discharge",
			disorient: true,
			dmg: 5,
			action: [0, 0, 0]
		}
	];

	public static var actionList:Null<Array<ActionData>>;

	public static function genActionList(): Array<ActionData> {
		if (Config.actionList == null) {
			Config.actionList = [{moveDist: 1, rotation: 0, anim: Res.art.green.g_side_walk.toTile().gridFlatten(240)}];
		}

		return Config.actionList;
	}
}
