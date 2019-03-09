package fp.component.gameonclient;

import coconut.data.List;
import coconut.data.Model;

class GameOnClientModel implements Model
{
	@:skipCheck @:observable var playerList:Array<Test> = null;

	@:transition function setList(v) return { playerList: v };
}

typedef Test = {
	@:optional var id(default, never):String;
	var avatar(default, never):String;
}