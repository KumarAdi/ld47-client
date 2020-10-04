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
    public static function run(users: Map<Int, UserInfo>): Array<Array<{userId: Int, action: Int}>> {
        return [];
    }
}