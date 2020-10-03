import haxe.Json;
import hxd.Res;

typedef CardData = {
    var name: String;
    var desc: String;
    var action: Array<Int>;
}

class Config {
    public static final boardWidth = 1920;
    public static final boardHeight = 1080;

    public static final uiColor = 0x065e91;

    public static final dirgaFont = Res.font.dirga.toFont();
    public static final stripeFont = Res.font.editundoline.toFont();
    
    public static final cardList: Array<CardData> = 
    [
        {name: "Move 1", desc: "Move one space forward", action: [0,1,0]},
        {name: "Move 2", desc: "Move two spaces forward", action: [0,2,0]}
    ];
}