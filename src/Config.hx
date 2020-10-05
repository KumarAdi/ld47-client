import h2d.Tile;
import hxd.Res;
import haxe.Json;

typedef CardData = {
	var name:String;
	var disorient:Bool;
	var dmg:Int;
	var action:Array<Int>;
}

enum AnimType {
    Stand;
    Walk;
    Flex;
}

typedef ActionData = {
	var moveDist: Int;
	var rotation: Int;
	var anim: AnimType;
}

class Config {
	public static final boardWidth = 1920;
	public static final boardHeight = 1080;

	public static final uiColor = 0x065e91;
	public static final uiSecondary = 0x063c5c;

    public static var actionList:Null<Array<ActionData>>;

	public static function genActionList():Array<ActionData> {
		if (Config.actionList == null) {
			Config.actionList = [
                {moveDist: 1, rotation: 0, anim: Walk},
                {moveDist: 0, rotation: 1, anim: Stand}
			];
		}

		return Config.actionList;
	}

    public static final cardList = [
        {name: "Move 1", disorient: false, dmg: 0, action: [1, 0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]},
        {name: "Move 1", disorient: false, dmg: 0, action: [0]}
    ];
}
