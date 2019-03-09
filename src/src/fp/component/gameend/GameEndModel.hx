package fp.component.gameend;

import coconut.data.Model;
import fp.component.gameonclient.GameOnClientModel.Test;

class GameEndModel implements Model
{
	@:skipCheck @:observable var playerList:Array<Test> = null;

	@:transition function setList(v) return { playerList: v };
}