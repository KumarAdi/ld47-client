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
	var dmg:Int;
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
					moveDist: 0, // 0 Nothing
					rotation: 0,
					anim: Stand,
					markers: [],
					dmg: 0,
				},
				{
					moveDist: 0, // 1 Left
					rotation: -1,
					anim: Stand,
					markers: [],
					dmg: 0,
				},
				{
					moveDist: 0, // 2 Right
					rotation: 1,
					anim: Stand,
					markers: [],
					dmg: 0,
				},
				{
					moveDist: 1, // 3 Forwards
					rotation: 0,
					anim: Walk,
					markers: [],
					dmg: 0,
				},
				{
					moveDist: -1, // 4 Backwards
					rotation: 0,
					anim: Walk,
					markers: [],
					dmg: 0,
				},
				{
					moveDist: 0, // 5 Front hit 2Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 1,
							y: 0
						},
					],
					dmg: 2,
				},
				{
					moveDist: 0, // 6 Front hit 5Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 1,
							y: 0
						},
					],
					dmg: 5,
				},
				{
					moveDist: 0, // 7 Front hit 6Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 1,
							y: 0
						},
					],
					dmg: 6,
				},
				{
					moveDist: 0, // 8 Front hit 10Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 1,
							y: 0
						},
					],
					dmg: 10,
				},
				{
					moveDist: 0, // 9 Left Axe  1Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
					],
					dmg: 1,
				},
				{
					moveDist: 0, // 10 Left Axe 3Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
					],
					dmg: 3,
				},
				{
					moveDist: 0, // 11 Left Axe 4Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
					],
					dmg: 4,
				},
				{
					moveDist: 0, // 12 Left Axe 5Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
					],
					dmg: 5,
				},
				{
					moveDist: 0, // 13 Left Axe 6Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
					],
					dmg: 6,
				},
				{
					moveDist: 0, // 14 Front Swipe 1Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 1,
							y: -1
						},
					],
					dmg: 1,
				},
				{
					moveDist: 0, // 15 Front Swipe 3Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 1,
							y: -1
						},
					],
					dmg: 3,
				},
				{
					moveDist: 0, // 16 Front Swipe 4Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 1,
							y: -1
						},
					],
					dmg: 4,
				},
				{
					moveDist: 0, // 17 Front Swipe 5Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 1,
							y: -1
						},
					],
					dmg: 3,
				},
				{
					moveDist: 0, // 18 Right Axe  1Dmg
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
							x: 1,
							y: -1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
					],
					dmg: 1,
				},
				{
					moveDist: 0, // 19 Right Axe 3Dmg
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
							x: 1,
							y: -1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
					],
					dmg: 3,
				},
				{
					moveDist: 0, // 20 Right Axe 4Dmg
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
							x: 1,
							y: -1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
					],
					dmg: 4,
				},
				{
					moveDist: 0, // 21 Right Axe 5Dmg
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
							x: 1,
							y: -1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
					],
					dmg: 5,
				},
				{
					moveDist: 0, // 22 Right Axe 6Dmg
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
							x: 1,
							y: -1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
					],
					dmg: 6,
				},
				{
					moveDist: 0, // 23 Stomp 1Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
						{
							marker: Slash,
							x: -1,
							y: 1
						},
						{
							marker: Slash,
							x: -1,
							y: 0
						},
						{
							marker: Slash,
							x: -1,
							y: -1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
						{
							marker: Slash,
							x: 1,
							y: -1
						},
					],
					dmg: 1,
				},
				{
					moveDist: 0, // 24 Stomp 2Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
						{
							marker: Slash,
							x: -1,
							y: 1
						},
						{
							marker: Slash,
							x: -1,
							y: 0
						},
						{
							marker: Slash,
							x: -1,
							y: -1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
						{
							marker: Slash,
							x: 1,
							y: -1
						},
					],
					dmg: 2,
				},
				{
					moveDist: 0, // 25 Stomp 3Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
						{
							marker: Slash,
							x: -1,
							y: 1
						},
						{
							marker: Slash,
							x: -1,
							y: 0
						},
						{
							marker: Slash,
							x: -1,
							y: -1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
						{
							marker: Slash,
							x: 1,
							y: -1
						},
					],
					dmg: 3,
				},
				{
					moveDist: 0, // 26 Stomp 4Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
						{
							marker: Slash,
							x: -1,
							y: 1
						},
						{
							marker: Slash,
							x: -1,
							y: 0
						},
						{
							marker: Slash,
							x: -1,
							y: -1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
						{
							marker: Slash,
							x: 1,
							y: -1
						},
					],
					dmg: 4,
				},
				{
					moveDist: 0, // 27 Stomp 5Dmg
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
							x: 1,
							y: 1
						},
						{
							marker: Slash,
							x: 0,
							y: 1
						},
						{
							marker: Slash,
							x: -1,
							y: 1
						},
						{
							marker: Slash,
							x: -1,
							y: 0
						},
						{
							marker: Slash,
							x: -1,
							y: -1
						},
						{
							marker: Slash,
							x: 0,
							y: -1
						},
						{
							marker: Slash,
							x: 1,
							y: -1
						},
					],
					dmg: 5,
				},
				{
					moveDist: 0, // 28 Wide Stomp 1Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 2,
							y: 0
						},
						{
							marker: Slash,
							x: 2,
							y: 1
						},
						{
							marker: Slash,
							x: 2,
							y: 2
						},
						{
							marker: Slash,
							x: 1,
							y: 2
						},
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: -1,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 1
						},
						{
							marker: Slash,
							x: -2,
							y: 0
						},
						{
							marker: Slash,
							x: -2,
							y: -1
						},
						{
							marker: Slash,
							x: -2,
							y: -2
						},
						{
							marker: Slash,
							x: -1,
							y: -2
						},
						{
							marker: Slash,
							x: 0,
							y: -2
						},
						{
							marker: Slash,
							x: 1,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -1
						},
					],
					dmg: 1,
				},
				{
					moveDist: 0, // 28 Wide Stomp 3Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 2,
							y: 0
						},
						{
							marker: Slash,
							x: 2,
							y: 1
						},
						{
							marker: Slash,
							x: 2,
							y: 2
						},
						{
							marker: Slash,
							x: 1,
							y: 2
						},
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: -1,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 1
						},
						{
							marker: Slash,
							x: -2,
							y: 0
						},
						{
							marker: Slash,
							x: -2,
							y: -1
						},
						{
							marker: Slash,
							x: -2,
							y: -2
						},
						{
							marker: Slash,
							x: -1,
							y: -2
						},
						{
							marker: Slash,
							x: 0,
							y: -2
						},
						{
							marker: Slash,
							x: 1,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -1
						},
					],
					dmg: 3,
				},
				{
					moveDist: 0, // 29 Wide Stomp 4Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 2,
							y: 0
						},
						{
							marker: Slash,
							x: 2,
							y: 1
						},
						{
							marker: Slash,
							x: 2,
							y: 2
						},
						{
							marker: Slash,
							x: 1,
							y: 2
						},
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: -1,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 1
						},
						{
							marker: Slash,
							x: -2,
							y: 0
						},
						{
							marker: Slash,
							x: -2,
							y: -1
						},
						{
							marker: Slash,
							x: -2,
							y: -2
						},
						{
							marker: Slash,
							x: -1,
							y: -2
						},
						{
							marker: Slash,
							x: 0,
							y: -2
						},
						{
							marker: Slash,
							x: 1,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -1
						},
					],
					dmg: 4,
				},
				{
					moveDist: 0, // 30 Wide Stomp 5Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 2,
							y: 0
						},
						{
							marker: Slash,
							x: 2,
							y: 1
						},
						{
							marker: Slash,
							x: 2,
							y: 2
						},
						{
							marker: Slash,
							x: 1,
							y: 2
						},
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: -1,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 1
						},
						{
							marker: Slash,
							x: -2,
							y: 0
						},
						{
							marker: Slash,
							x: -2,
							y: -1
						},
						{
							marker: Slash,
							x: -2,
							y: -2
						},
						{
							marker: Slash,
							x: -1,
							y: -2
						},
						{
							marker: Slash,
							x: 0,
							y: -2
						},
						{
							marker: Slash,
							x: 1,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -1
						},
					],
					dmg: 5,
				},
				{
					moveDist: 0, // 31 Wide Stomp 7Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 2,
							y: 0
						},
						{
							marker: Slash,
							x: 2,
							y: 1
						},
						{
							marker: Slash,
							x: 2,
							y: 2
						},
						{
							marker: Slash,
							x: 1,
							y: 2
						},
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: -1,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 1
						},
						{
							marker: Slash,
							x: -2,
							y: 0
						},
						{
							marker: Slash,
							x: -2,
							y: -1
						},
						{
							marker: Slash,
							x: -2,
							y: -2
						},
						{
							marker: Slash,
							x: -1,
							y: -2
						},
						{
							marker: Slash,
							x: 0,
							y: -2
						},
						{
							marker: Slash,
							x: 1,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -1
						},
					],
					dmg: 7,
				},
				{
					moveDist: 0, // 32 Wide Stomp 9Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 2,
							y: 0
						},
						{
							marker: Slash,
							x: 2,
							y: 1
						},
						{
							marker: Slash,
							x: 2,
							y: 2
						},
						{
							marker: Slash,
							x: 1,
							y: 2
						},
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: -1,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 1
						},
						{
							marker: Slash,
							x: -2,
							y: 0
						},
						{
							marker: Slash,
							x: -2,
							y: -1
						},
						{
							marker: Slash,
							x: -2,
							y: -2
						},
						{
							marker: Slash,
							x: -1,
							y: -2
						},
						{
							marker: Slash,
							x: 0,
							y: -2
						},
						{
							marker: Slash,
							x: 1,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -2
						},
						{
							marker: Slash,
							x: 2,
							y: -1
						},
					],
					dmg: 9,
				},
				{
					moveDist: 0, // 33 Wide Left 4Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: -1,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 1
						},
						{
							marker: Slash,
							x: -2,
							y: 0
						},
					],
					dmg: 4,
				},
				{
					moveDist: 0, // 34 Wide Left 5Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: -1,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 1
						},
						{
							marker: Slash,
							x: -2,
							y: 0
						},
					],
					dmg: 5,
				},
				{
					moveDist: 0, // 35 Wide Left 8Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: -1,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 1
						},
						{
							marker: Slash,
							x: -2,
							y: 0
						},
					],
					dmg: 8,
				},
				{
					moveDist: 0, // 36 Wide Right 4Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: 1,
							y: 2
						},
						{
							marker: Slash,
							x: 2,
							y: 2
						},
						{
							marker: Slash,
							x: 2,
							y: 1
						},
						{
							marker: Slash,
							x: 2,
							y: 0
						},
					],
					dmg: 4,
				},
				{
					moveDist: 0, // 37 Wide Right 5Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: 1,
							y: 2
						},
						{
							marker: Slash,
							x: 2,
							y: 2
						},
						{
							marker: Slash,
							x: 2,
							y: 1
						},
						{
							marker: Slash,
							x: 2,
							y: 0
						},
					],
					dmg: 5,
				},
				{
					moveDist: 0, // 38 Wide Right 8Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Slash,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: 1,
							y: 2
						},
						{
							marker: Slash,
							x: 2,
							y: 2
						},
						{
							marker: Slash,
							x: 2,
							y: 1
						},
						{
							marker: Slash,
							x: 2,
							y: 0
						},
					],
					dmg: 8,
				},
				{
					moveDist: 0, // 39 Heavy Blade 3Dmg
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
							x: 2,
							y: 0
						},
					],
					dmg: 3,
				},
				{
					moveDist: 0, // 40 Heavy Blade 5Dmg
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
							x: 2,
							y: 0
						},
					],
					dmg: 5,
				},
				{
					moveDist: 0, // 41 Heavy Blade 20Dmg
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
							x: 2,
							y: 0
						},
					],
					dmg: 20,
				},
			];
		}

		return Config.actionList;
	}

	public static final cardList = [
		{ // move 1
			name: "Move 1",
			disorient: false,
			dmg: 0,
			action: [3]
		},
		{ // move 2
			name: "Move 2",
			disorient: false,
			dmg: 0,
			action: [3, 3]
		},
		{ // move 3
			name: "Move 3",
			disorient: false,
			dmg: 0,
			action: [3, 3, 3]
		},
		{ // reverse
			name: "Reverse",
			disorient: false,
			dmg: 0,
			action: [4]
		},
		{ // turn left
			name: "Turn Left",
			disorient: false,
			dmg: 0,
			action: [1]
		},
		{ // turn right
			name: "Turn Right",
			disorient: false,
			dmg: 0,
			action: [2]
		},
		{ // u-turn
			name: "U-Turn",
			disorient: false,
			dmg: 0,
			action: [1, 1]
		},
		{ // reposition
			name: "Reposition",
			disorient: false,
			dmg: 0,
			action: [4, 4, 4]
		},
		{ // Quickstep
			name: "Quickstep",
			disorient: false,
			dmg: 0,
			action: [3, 4]
		},
		{ // punch
			name: "Punch",
			disorient: false,
			dmg: 2,
			action: [5]
		},
		{ // discharge
			name: "Discharge",
			disorient: false,
			dmg: 1,
			action: [23, 28]
		},
		{ // charge
			name: "Charge",
			disorient: false,
			dmg: 2,
			action: [3, 3, 3, 3, 6]
		},
		{ // Brrrrr
			name: "Brrrrr",
			disorient: false,
			dmg: 2,
			action: [18, 14, 9, 9, 14, 18]
		},
		{ // Slash Left
			name: "Slash Left",
			disorient: false,
			dmg: 2,
			action: [3, 10]
		},
		{ // Slash Right
			name: "Slash Right",
			disorient: false,
			dmg: 2,
			action: [3, 19]
		},
		{ // Slash and Dash
			name: "Slash and Dash",
			disorient: false,
			dmg: 2,
			action: [15, 4]
		},
		{ // Erupt
			name: "Erupt",
			disorient: false,
			dmg: 2,
			action: [31]
		},
		{ // Pyromancy
			name: "Pyromancy",
			disorient: false,
			dmg: 2,
			action: [20, 37, 11, 34]
		},
		{ // Bonk
			name: "Bonk",
			disorient: false,
			dmg: 2,
			action: [6]
		},
		{ // Hard Swing
			name: "Hard Swing",
			disorient: false,
			dmg: 2,
			action: [1, 7]
		},
		{ // Forward Thrust
			name: "Forward Thrust",
			disorient: false,
			dmg: 2,
			action: [3, 40]
		},
		{ // Clear Area
			name: "Clear Area",
			disorient: false,
			dmg: 2,
			action: [25, 29]
		},
		{ // Starry Haymaker
			name: "Starry Haymaker",
			disorient: false,
			dmg: 2,
			action: [3, 3, 8]
		},
		{ // Charged One-Two
			name: "Charged One-Two",
			disorient: false,
			dmg: 2,
			action: [13, 22]
		},
		{ // Electric Sweeps
			name: "Electric Sweeps",
			disorient: false,
			dmg: 2,
			action: [30, 30]
		},
		{ // Whipping Strikes
			name: "Whipping Strikes",
			disorient: false,
			dmg: 2,
			action: [37, 34]
		},
		{ // Chop
			name: "Chop",
			disorient: false,
			dmg: 2,
			action: [16]
		},
		{ // Spin Attack
			name: "Spin Attack",
			disorient: false,
			dmg: 2,
			action: [24, 24]
		},
		{ // Wind Circle
			name: "Wind Circle",
			disorient: false,
			dmg: 2,
			action: [29, 29, 29, 29]
		},
		{ // Flaming Slash
			name: "Flaming Slash",
			disorient: false,
			dmg: 2,
			action: [35, 38, 41]
		},
		{ // Toxic Bubble
			name: "Toxic Bubble",
			disorient: false,
			dmg: 2,
			action: [26, 30, 30]
		},
		{ // Frost Shards
			name: "Frost Shards",
			disorient: false,
			dmg: 2,
			action: [33]
		},
		{ // Dissonant Chord
			name: "Dissonant Chord",
			disorient: false,
			dmg: 2,
			action: [27, 31]
		},
		{ // Cometcall Melody
			name: "Cometcall Melody",
			disorient: false,
			dmg: 2,
			action: [32, 32]
		},
		{ // BRRRRRR
			name: "BRRRRRR",
			disorient: false,
			dmg: 2,
			action: [38, 21, 17, 12, 35]
		},
		{ // Sweep Left
			name: "Sweep Left",
			disorient: false,
			dmg: 2,
			action: [3, 36]
		},
		{ // Sweep Right
			name: "Sweep Right",
			disorient: false,
			dmg: 2,
			action: [3, 39]
		},
		{ // The Heaviest Blade
			name: "The Heaviest Blade",
			disorient: false,
			dmg: 2,
			action: [42]
		},
	];
}
