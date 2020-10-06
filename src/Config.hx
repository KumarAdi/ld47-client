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
	Bubble;
	Electricity;
	Fire;
	Ice;
	Music;
	MusicBig;
	Punch;
	Stab;
	Whip;
	WideSlash;
	Wind;
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
				{ // 0 Nothing
					moveDist: 0, // 0 Nothing
					rotation: 0,
					anim: Stand,
					markers: [],
					dmg: 0,
				},
				{ // 1 Left
					moveDist: 0, // 1 Left
					rotation: -1,
					anim: Stand,
					markers: [],
					dmg: 0,
				},
				{ // 2 Right
					moveDist: 0, // 2 Right
					rotation: 1,
					anim: Stand,
					markers: [],
					dmg: 0,
				},
				{ // 3 Forwards
					moveDist: 1, // 3 Forwards
					rotation: 0,
					anim: Walk,
					markers: [],
					dmg: 0,
				},
				{ // 4 Backwards
					moveDist: -1, // 4 Backwards
					rotation: 0,
					anim: Walk,
					markers: [],
					dmg: 0,
				},
				{ // 5 Front hit 2Dmg
					moveDist: 0, // 5 Front hit 2Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Punch,
							x: 1,
							y: 0
						},
					],
					dmg: 2,
				},
				{ // 6 Front hit 5Dmg
					moveDist: 0, // 6 Front hit 5Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Punch,
							x: 1,
							y: 0
						},
					],
					dmg: 5,
				},
				{ // 7 Front hit 6Dmg
					moveDist: 0, // 7 Front hit 6Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Punch,
							x: 1,
							y: 0
						},
					],
					dmg: 6,
				},
				{ // 8 Front hit 10Dmg
					moveDist: 0, // 8 Front hit 10Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Punch,
							x: 1,
							y: 0
						},
					],
					dmg: 10,
				},
				{ // 9 Left Axe  1Dmg
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
				{ // 10 Left Axe 3Dmg
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
				{ // 11 Left Axe 4Dmg
					moveDist: 0, // 11 Left Axe 4Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Fire,
							x: 1,
							y: 0
						},
						{
							marker: Fire,
							x: 1,
							y: 1
						},
						{
							marker: Fire,
							x: 0,
							y: 1
						},
					],
					dmg: 4,
				},
				{ // 12 Left Axe 5Dmg
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
				{ // 13 Left Axe 6Dmg
					moveDist: 0, // 13 Left Axe 6Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Electricity,
							x: 1,
							y: 0
						},
						{
							marker: Punch,
							x: 1,
							y: 1
						},
						{
							marker: Electricity,
							x: 0,
							y: 1
						},
					],
					dmg: 6,
				},
				{ // 14 Front Swipe 1Dmg
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
				{ // 15 Front Swipe 3Dmg
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
				{ // 16 Front Swipe 4Dmg
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
				{ // 17 Front Swipe 5Dmg
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
				{ // 18 Right Axe  1Dmg
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
				{ // 19 Right Axe 3Dmg
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
				{ // 20 Right Axe 4Dmg
					moveDist: 0, // 20 Right Axe 4Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Fire,
							x: 1,
							y: 0
						},
						{
							marker: Fire,
							x: 1,
							y: -1
						},
						{
							marker: Fire,
							x: 0,
							y: -1
						},
					],
					dmg: 4,
				},
				{ // 21 Right Axe 5Dmg
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
				{ // 22 Right Axe 6Dmg
					moveDist: 0, // 22 Right Axe 6Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Electricity,
							x: 1,
							y: 0
						},
						{
							marker: Punch,
							x: 1,
							y: -1
						},
						{
							marker: Electricity,
							x: 0,
							y: -1
						},
					],
					dmg: 6,
				},
				{ // 23 Stomp 1Dmg
					moveDist: 0, // 23 Stomp 1Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Electricity,
							x: 1,
							y: 0
						},
						{
							marker: Electricity,
							x: 1,
							y: 1
						},
						{
							marker: Electricity,
							x: 0,
							y: 1
						},
						{
							marker: Electricity,
							x: -1,
							y: 1
						},
						{
							marker: Electricity,
							x: -1,
							y: 0
						},
						{
							marker: Electricity,
							x: -1,
							y: -1
						},
						{
							marker: Electricity,
							x: 0,
							y: -1
						},
						{
							marker: Electricity,
							x: 1,
							y: -1
						},
					],
					dmg: 1,
				},
				{ // 24 Stomp 2Dmg
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
				{ // 25 Stomp 3Dmg
					moveDist: 0, // 25 Stomp 3Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Whip,
							x: 1,
							y: 0
						},
						{
							marker: Whip,
							x: 1,
							y: 1
						},
						{
							marker: Whip,
							x: 0,
							y: 1
						},
						{
							marker: Whip,
							x: -1,
							y: 1
						},
						{
							marker: Whip,
							x: -1,
							y: 0
						},
						{
							marker: Whip,
							x: -1,
							y: -1
						},
						{
							marker: Whip,
							x: 0,
							y: -1
						},
						{
							marker: Whip,
							x: 1,
							y: -1
						},
					],
					dmg: 3,
				},
				{ // 26 Stomp 4Dmg
					moveDist: 0, // 26 Stomp 4Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Bubble,
							x: 1,
							y: 0
						},
						{
							marker: Bubble,
							x: 1,
							y: 1
						},
						{
							marker: Bubble,
							x: 0,
							y: 1
						},
						{
							marker: Bubble,
							x: -1,
							y: 1
						},
						{
							marker: Bubble,
							x: -1,
							y: 0
						},
						{
							marker: Bubble,
							x: -1,
							y: -1
						},
						{
							marker: Bubble,
							x: 0,
							y: -1
						},
						{
							marker: Bubble,
							x: 1,
							y: -1
						},
					],
					dmg: 4,
				},
				{ // 27 Stomp 5Dmg
					moveDist: 0, // 27 Stomp 5Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Music,
							x: 1,
							y: 0
						},
						{
							marker: Music,
							x: 1,
							y: 1
						},
						{
							marker: Music,
							x: 0,
							y: 1
						},
						{
							marker: Music,
							x: -1,
							y: 1
						},
						{
							marker: Music,
							x: -1,
							y: 0
						},
						{
							marker: Music,
							x: -1,
							y: -1
						},
						{
							marker: Music,
							x: 0,
							y: -1
						},
						{
							marker: Music,
							x: 1,
							y: -1
						},
					],
					dmg: 5,
				},
				{ // 28 Wide Stomp 1Dmg
					moveDist: 0, // 28 Wide Stomp 1Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Electricity,
							x: 2,
							y: 0
						},
						{
							marker: Electricity,
							x: 2,
							y: 1
						},
						{
							marker: Electricity,
							x: 2,
							y: 2
						},
						{
							marker: Electricity,
							x: 1,
							y: 2
						},
						{
							marker: Electricity,
							x: 0,
							y: 2
						},
						{
							marker: Electricity,
							x: -1,
							y: 2
						},
						{
							marker: Electricity,
							x: -2,
							y: 2
						},
						{
							marker: Electricity,
							x: -2,
							y: 1
						},
						{
							marker: Electricity,
							x: -2,
							y: 0
						},
						{
							marker: Electricity,
							x: -2,
							y: -1
						},
						{
							marker: Electricity,
							x: -2,
							y: -2
						},
						{
							marker: Electricity,
							x: -1,
							y: -2
						},
						{
							marker: Electricity,
							x: 0,
							y: -2
						},
						{
							marker: Electricity,
							x: 1,
							y: -2
						},
						{
							marker: Electricity,
							x: 2,
							y: -2
						},
						{
							marker: Electricity,
							x: 2,
							y: -1
						},
					],
					dmg: 1,
				},
				{ // 29 Wide Stomp 3Dmg
					moveDist: 0, // 28 Wide Stomp 3Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Wind,
							x: 2,
							y: 0
						},
						{
							marker: Wind,
							x: 2,
							y: 1
						},
						{
							marker: Wind,
							x: 2,
							y: 2
						},
						{
							marker: Wind,
							x: 1,
							y: 2
						},
						{
							marker: Wind,
							x: 0,
							y: 2
						},
						{
							marker: Wind,
							x: -1,
							y: 2
						},
						{
							marker: Wind,
							x: -2,
							y: 2
						},
						{
							marker: Wind,
							x: -2,
							y: 1
						},
						{
							marker: Wind,
							x: -2,
							y: 0
						},
						{
							marker: Wind,
							x: -2,
							y: -1
						},
						{
							marker: Wind,
							x: -2,
							y: -2
						},
						{
							marker: Wind,
							x: -1,
							y: -2
						},
						{
							marker: Wind,
							x: 0,
							y: -2
						},
						{
							marker: Wind,
							x: 1,
							y: -2
						},
						{
							marker: Wind,
							x: 2,
							y: -2
						},
						{
							marker: Wind,
							x: 2,
							y: -1
						},
					],
					dmg: 3,
				},
				{ // 30 Wide Stomp 4Dmg
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Bubble,
							x: 2,
							y: 0
						},
						{
							marker: Bubble,
							x: 2,
							y: 1
						},
						{
							marker: Bubble,
							x: 2,
							y: 2
						},
						{
							marker: Bubble,
							x: 1,
							y: 2
						},
						{
							marker: Bubble,
							x: 0,
							y: 2
						},
						{
							marker: Bubble,
							x: -1,
							y: 2
						},
						{
							marker: Bubble,
							x: -2,
							y: 2
						},
						{
							marker: Bubble,
							x: -2,
							y: 1
						},
						{
							marker: Bubble,
							x: -2,
							y: 0
						},
						{
							marker: Bubble,
							x: -2,
							y: -1
						},
						{
							marker: Bubble,
							x: -2,
							y: -2
						},
						{
							marker: Bubble,
							x: -1,
							y: -2
						},
						{
							marker: Bubble,
							x: 0,
							y: -2
						},
						{
							marker: Bubble,
							x: 1,
							y: -2
						},
						{
							marker: Bubble,
							x: 2,
							y: -2
						},
						{
							marker: Bubble,
							x: 2,
							y: -1
						},
					],
					dmg: 4,
				},
				{ // 31 Wide Stomp 5Dmg
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Fire,
							x: 2,
							y: 0
						},
						{
							marker: Fire,
							x: 2,
							y: 1
						},
						{
							marker: Fire,
							x: 2,
							y: 2
						},
						{
							marker: Fire,
							x: 1,
							y: 2
						},
						{
							marker: Fire,
							x: 0,
							y: 2
						},
						{
							marker: Fire,
							x: -1,
							y: 2
						},
						{
							marker: Fire,
							x: -2,
							y: 2
						},
						{
							marker: Fire,
							x: -2,
							y: 1
						},
						{
							marker: Fire,
							x: -2,
							y: 0
						},
						{
							marker: Fire,
							x: -2,
							y: -1
						},
						{
							marker: Fire,
							x: -2,
							y: -2
						},
						{
							marker: Fire,
							x: -1,
							y: -2
						},
						{
							marker: Fire,
							x: 0,
							y: -2
						},
						{
							marker: Fire,
							x: 1,
							y: -2
						},
						{
							marker: Fire,
							x: 2,
							y: -2
						},
						{
							marker: Fire,
							x: 2,
							y: -1
						},
					],
					dmg: 5,
				},
				{ // 32 Wide Stomp 7Dmg
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: MusicBig,
							x: 2,
							y: 0
						},
						{
							marker: MusicBig,
							x: 2,
							y: 1
						},
						{
							marker: MusicBig,
							x: 2,
							y: 2
						},
						{
							marker: MusicBig,
							x: 1,
							y: 2
						},
						{
							marker: MusicBig,
							x: 0,
							y: 2
						},
						{
							marker: MusicBig,
							x: -1,
							y: 2
						},
						{
							marker: MusicBig,
							x: -2,
							y: 2
						},
						{
							marker: MusicBig,
							x: -2,
							y: 1
						},
						{
							marker: MusicBig,
							x: -2,
							y: 0
						},
						{
							marker: MusicBig,
							x: -2,
							y: -1
						},
						{
							marker: MusicBig,
							x: -2,
							y: -2
						},
						{
							marker: MusicBig,
							x: -1,
							y: -2
						},
						{
							marker: MusicBig,
							x: 0,
							y: -2
						},
						{
							marker: MusicBig,
							x: 1,
							y: -2
						},
						{
							marker: MusicBig,
							x: 2,
							y: -2
						},
						{
							marker: MusicBig,
							x: 2,
							y: -1
						},
					],
					dmg: 7,
				},
				{ // 33 Wide Stomp 9Dmg
					moveDist: 0, // 32 Wide Stomp 9Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Ice,
							x: 2,
							y: 0
						},
						{
							marker: Ice,
							x: 2,
							y: 1
						},
						{
							marker: Ice,
							x: 2,
							y: 2
						},
						{
							marker: Ice,
							x: 1,
							y: 2
						},
						{
							marker: Ice,
							x: 0,
							y: 2
						},
						{
							marker: Ice,
							x: -1,
							y: 2
						},
						{
							marker: Ice,
							x: -2,
							y: 2
						},
						{
							marker: Ice,
							x: -2,
							y: 1
						},
						{
							marker: Ice,
							x: -2,
							y: 0
						},
						{
							marker: Ice,
							x: -2,
							y: -1
						},
						{
							marker: Ice,
							x: -2,
							y: -2
						},
						{
							marker: Ice,
							x: -1,
							y: -2
						},
						{
							marker: Ice,
							x: 0,
							y: -2
						},
						{
							marker: Ice,
							x: 1,
							y: -2
						},
						{
							marker: Ice,
							x: 2,
							y: -2
						},
						{
							marker: Ice,
							x: 2,
							y: -1
						},
					],
					dmg: 9,
				},
				{ // 34 Wide Left 4Dmg
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Whip,
							x: 0,
							y: 2
						},
						{
							marker: Whip,
							x: -1,
							y: 2
						},
						{
							marker: Whip,
							x: -2,
							y: 2
						},
						{
							marker: Whip,
							x: -2,
							y: 1
						},
						{
							marker: Whip,
							x: -2,
							y: 0
						},
					],
					dmg: 4,
				},
				{ // 35 Wide Left 5Dmg
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: WideSlash,
							x: 0,
							y: 2
						},
						{
							marker: WideSlash,
							x: -1,
							y: 2
						},
						{
							marker: WideSlash,
							x: -2,
							y: 2
						},
						{
							marker: WideSlash,
							x: -2,
							y: 1
						},
						{
							marker: WideSlash,
							x: -2,
							y: 0
						},
					],
					dmg: 5,
				},
				{ // 36 Wide Left 8Dmg
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: WideSlash,
							x: 0,
							y: 2
						},
						{
							marker: WideSlash,
							x: -1,
							y: 2
						},
						{
							marker: WideSlash,
							x: -2,
							y: 2
						},
						{
							marker: WideSlash,
							x: -2,
							y: 1
						},
						{
							marker: WideSlash,
							x: -2,
							y: 0
						},
					],
					dmg: 8,
				},
				{ // 37 Wide Right 4Dmg
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Whip,
							x: 0,
							y: 2
						},
						{
							marker: Whip,
							x: 1,
							y: 2
						},
						{
							marker: Whip,
							x: 2,
							y: 2
						},
						{
							marker: Whip,
							x: 2,
							y: 1
						},
						{
							marker: Whip,
							x: 2,
							y: 0
						},
					],
					dmg: 4,
				},
				{ // 38 Wide Right 5Dmg
					moveDist: 0, // 37 Wide Right 5Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: WideSlash,
							x: 0,
							y: 2
						},
						{
							marker: WideSlash,
							x: 1,
							y: 2
						},
						{
							marker: WideSlash,
							x: 2,
							y: 2
						},
						{
							marker: WideSlash,
							x: 2,
							y: 1
						},
						{
							marker: WideSlash,
							x: 2,
							y: 0
						},
					],
					dmg: 5,
				},
				{ // 39 Wide Right 8Dmg
					moveDist: 0, // 38 Wide Right 8Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: WideSlash,
							x: 0,
							y: 2
						},
						{
							marker: WideSlash,
							x: 1,
							y: 2
						},
						{
							marker: WideSlash,
							x: 2,
							y: 2
						},
						{
							marker: WideSlash,
							x: 2,
							y: 1
						},
						{
							marker: WideSlash,
							x: 2,
							y: 0
						},
					],
					dmg: 8,
				},
				{ // 40 Heavy Blade 3Dmg
					moveDist: 0, // 39 Heavy Blade 3Dmg
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Stab,
							x: 1,
							y: 0
						},
						{
							marker: Stab,
							x: 2,
							y: 0
						},
					],
					dmg: 3,
				},
				{ // 41 Heavy Blade 5Dmg
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Stab,
							x: 1,
							y: 0
						},
						{
							marker: Fire,
							x: 2,
							y: 0
						},
					],
					dmg: 5,
				},
				{ // 42 Heavy Blade 20Dmg
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: WideSlash,
							x: 1,
							y: 0
						},
						{
							marker: Punch,
							x: 2,
							y: 0
						},
					],
					dmg: 20,
				},
				{ // 43 Wide Stomp 4Dmg - For Electric Sweeps
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Electricity,
							x: 2,
							y: 0
						},
						{
							marker: Slash,
							x: 2,
							y: 1
						},
						{
							marker: Electricity,
							x: 2,
							y: 2
						},
						{
							marker: Slash,
							x: 1,
							y: 2
						},
						{
							marker: Electricity,
							x: 0,
							y: 2
						},
						{
							marker: Slash,
							x: -1,
							y: 2
						},
						{
							marker: Electricity,
							x: -2,
							y: 2
						},
						{
							marker: Slash,
							x: -2,
							y: 1
						},
						{
							marker: Electricity,
							x: -2,
							y: 0
						},
						{
							marker: Slash,
							x: -2,
							y: -1
						},
						{
							marker: Electricity,
							x: -2,
							y: -2
						},
						{
							marker: Slash,
							x: -1,
							y: -2
						},
						{
							marker: Electricity,
							x: 0,
							y: -2
						},
						{
							marker: Slash,
							x: 1,
							y: -2
						},
						{
							marker: Electricity,
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
				{ // 44 Wide Stomp 5Dmg - For Dissonant Chord
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: MusicBig,
							x: 2,
							y: 0
						},
						{
							marker: MusicBig,
							x: 2,
							y: 1
						},
						{
							marker: MusicBig,
							x: 2,
							y: 2
						},
						{
							marker: MusicBig,
							x: 1,
							y: 2
						},
						{
							marker: MusicBig,
							x: 0,
							y: 2
						},
						{
							marker: MusicBig,
							x: -1,
							y: 2
						},
						{
							marker: MusicBig,
							x: -2,
							y: 2
						},
						{
							marker: MusicBig,
							x: -2,
							y: 1
						},
						{
							marker: MusicBig,
							x: -2,
							y: 0
						},
						{
							marker: MusicBig,
							x: -2,
							y: -1
						},
						{
							marker: MusicBig,
							x: -2,
							y: -2
						},
						{
							marker: MusicBig,
							x: -1,
							y: -2
						},
						{
							marker: MusicBig,
							x: 0,
							y: -2
						},
						{
							marker: MusicBig,
							x: 1,
							y: -2
						},
						{
							marker: MusicBig,
							x: 2,
							y: -2
						},
						{
							marker: MusicBig,
							x: 2,
							y: -1
						},
					],
					dmg: 5,
				},
				{ // 45 Wide Left 4Dmg  - For Pyromancy
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Fire,
							x: 0,
							y: 2
						},
						{
							marker: Fire,
							x: -1,
							y: 2
						},
						{
							marker: Fire,
							x: -2,
							y: 2
						},
						{
							marker: Fire,
							x: -2,
							y: 1
						},
						{
							marker: Fire,
							x: -2,
							y: 0
						},
					],
					dmg: 4,
				},
				{ // 46 Wide Right 4Dmg - For Pyromancy
					moveDist: 0,
					rotation: 0,
					anim: Flex,
					markers: [
						{
							marker: Fire,
							x: 0,
							y: 2
						},
						{
							marker: Fire,
							x: 1,
							y: 2
						},
						{
							marker: Fire,
							x: 2,
							y: 2
						},
						{
							marker: Fire,
							x: 2,
							y: 1
						},
						{
							marker: Fire,
							x: 2,
							y: 0
						},
					],
					dmg: 4,
				},
			];
		}

		return Config.actionList;
	}

	public static final cardList = [
		{ // Move 1
			name: "Move 1",
			disorient: false,
			dmg: 0,
			action: [3]
		},
		{ // Move 2
			name: "Move 2",
			disorient: false,
			dmg: 0,
			action: [3, 3]
		},
		{ // Move 3
			name: "Move 3",
			disorient: false,
			dmg: 0,
			action: [3, 3, 3]
		},
		{ // Reverse
			name: "Reverse",
			disorient: false,
			dmg: 0,
			action: [4]
		},
		{ // Turn left
			name: "Turn Left",
			disorient: false,
			dmg: 0,
			action: [1]
		},
		{ // Turn right
			name: "Turn Right",
			disorient: false,
			dmg: 0,
			action: [2]
		},
		{ // U-turn
			name: "U-Turn",
			disorient: false,
			dmg: 0,
			action: [1, 1]
		},
		{ // Reposition
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
		{ // Punch|
			name: "Punch",
			disorient: false,
			dmg: 2,
			action: [5]
		},
		{ // Discharge|
			name: "Discharge",
			disorient: false,
			dmg: 1,
			action: [23, 28]
		},
		{ // Charge|
			name: "Charge",
			disorient: false,
			dmg: 2,
			action: [3, 3, 3, 3, 6]
		},
		{ // Brrrrr|
			name: "Brrrrr",
			disorient: false,
			dmg: 2,
			action: [18, 14, 9, 9, 14, 18]
		},
		{ // Slash Left|
			name: "Slash Left",
			disorient: false,
			dmg: 2,
			action: [3, 10]
		},
		{ // Slash Right|
			name: "Slash Right",
			disorient: false,
			dmg: 2,
			action: [3, 19]
		},
		{ // Slash and Dash|
			name: "Slash and Dash",
			disorient: false,
			dmg: 2,
			action: [15, 4]
		},
		{ // Erupt|
			name: "Erupt",
			disorient: false,
			dmg: 2,
			action: [31]
		},
		{ // Pyromancy| Switch to 20, 46, 11, 45
			name: "Pyromancy",
			disorient: false,
			dmg: 2,
			action: [20, 37, 11, 34]
		},
		{ // Bonk|
			name: "Bonk",
			disorient: false,
			dmg: 2,
			action: [6]
		},
		{ // Hard Swing|
			name: "Hard Swing",
			disorient: false,
			dmg: 2,
			action: [1, 7]
		},
		{ // Forward Thrust|
			name: "Forward Thrust",
			disorient: false,
			dmg: 2,
			action: [3, 40]
		},
		{ // Clear Area|
			name: "Clear Area",
			disorient: false,
			dmg: 2,
			action: [25, 29]
		},
		{ // Starry Haymaker|
			name: "Starry Haymaker",
			disorient: false,
			dmg: 2,
			action: [3, 3, 8]
		},
		{ // Charged One-Two|
			name: "Charged One-Two",
			disorient: false,
			dmg: 2,
			action: [13, 22]
		},
		{ // Electric Sweeps| Switch to 43,43
			name: "Electric Sweeps",
			disorient: false,
			dmg: 2,
			action: [30, 30]
		},
		{ // Whipping Strikes|
			name: "Whipping Strikes",
			disorient: false,
			dmg: 2,
			action: [37, 34]
		},
		{ // Chop|
			name: "Chop",
			disorient: false,
			dmg: 2,
			action: [16]
		},
		{ // Spin Attack|
			name: "Spin Attack",
			disorient: false,
			dmg: 2,
			action: [24, 24]
		},
		{ // Wind Circle|
			name: "Wind Circle",
			disorient: false,
			dmg: 2,
			action: [29, 29, 29, 29]
		},
		{ // Flaming Slash|
			name: "Flaming Slash",
			disorient: false,
			dmg: 2,
			action: [35, 38, 41]
		},
		{ // Toxic Bubble	|
			name: "Toxic Bubble",
			disorient: false,
			dmg: 2,
			action: [26, 30, 30]
		},
		{ // Frost Shards |
			name: "Frost Shards",
			disorient: false,
			dmg: 2,
			action: [33]
		},
		{ // Dissonant Chord | Switch to 27, 44
			name: "Dissonant Chord",
			disorient: false,
			dmg: 2,
			action: [27, 31]
		},
		{ // Cometcall Melody |
			name: "Cometcall Melody",
			disorient: false,
			dmg: 2,
			action: [32, 32]
		},
		{ // BRRRRRR |
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
