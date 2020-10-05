package scenes;

import scenes.BoardManager.UserInfo;
import haxe.ds.Map;

class ExecutionEngine {

    /**
     * executes the programs of the users for one round
     * 
     * @param users the user info, containing updated programs for all users
     * @return Array<Array<Int>> an array of tiks, each tik is an array of actions that go off during that tic
     */
    public static function run(users: Map<Int, UserInfo>): Array<Map<Int, Int>> {
        var ret: Array<Map<Int, Int>> = [];
        for (userId in users.keys()) {
            var user = users.get(userId);
            var actionCount = 0;
            for (card in user.program) {
                var cardInfo = Config.cardList[card];
                for (action in cardInfo.action) {
                    while (actionCount >= ret.length) {
                        ret.push([]);
                    }
                    ret[actionCount].set(userId,action);
                    actionCount++;
                }
            }
        }
        return ret;
    }
}