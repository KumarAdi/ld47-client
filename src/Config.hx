import h2d.Tile;
import hxd.Res;
import haxe.Json;

typedef CardData = {
	var name:String;
	var disorient:Bool;
	var action:Array<Int>;
}

enum AnimType {
	Stand;
	Walk;
	Flex;
}

enum MarkerType {
    Slash;
}

typedef ActionData = {
	var moveDist:Int;
	var rotation:Int;
	var anim:AnimType;
    var markers:Array<{marker:MarkerType, x:Int, y:Int}>;
    var dmg: Int;
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
				{
					moveDist: 0,
					rotation: 0,
					anim: Stand,
                    markers: [],
                    dmg: 0,
				},
				{
					moveDist: 0,
					rotation: -1,
					anim: Stand,
                    markers: [],
                    dmg: 0,
				},
				{
					moveDist: 0,
					rotation: 1,
					anim: Stand,
                    markers: [],
                    dmg: 0,
				},
				{
					moveDist: 1,
					rotation: 0,
					anim: Walk,
                    markers: [],
                    dmg: 0,
				},
				{
					moveDist: -1,
					rotation: 0,
					anim: Walk,
                    markers: [],
                    dmg: 0,
				},
				{
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 1,
							y: 0
						},
						{
							marker: Slash,
							x: -1,
							y: 0
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
                    ],
                    dmg: 1,
				},
			];
		}

		return Config.actionList;
	}

	public static final cardList = [
		{
			name: "Move 1",
			disorient: false,
			dmg: 0,
			action: [3]
		},
		{
			name: "Move 2",
			disorient: false,
			dmg: 0,
			action: [3, 3]
		},
		{
			name: "Move 3",
			disorient: false,
			dmg: 0,
			action: [3, 3, 3]
		},
		{
			name: "Reverse",
			disorient: false,
			dmg: 0,
			action: [4]
		},
		{
			name: "Turn Left",
			disorient: false,
			dmg: 0,
			action: [1]
		},
		{
			name: "Turn Right",
			disorient: false,
			dmg: 0,
			action: [2]
		},
		{
			name: "U-Turn",
			disorient: false,
			dmg: 0,
			action: [1, 1]
		},
		{
			name: "Reposition",
			disorient: false,
			dmg: 0,
			action: [4, 4, 4]
		},
		{
			name: "Act Erratically",
			disorient: false,
			dmg: 0,
			action: [3, 1, 4, 3, 2, 4]
		},
		{
			name: "Slash",
			disorient: false,
			dmg: 1,
			action: [5]
		}
	];
}
