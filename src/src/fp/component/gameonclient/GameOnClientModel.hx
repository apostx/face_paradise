package fp.component.gameonclient;

import coconut.data.List;
import coconut.data.Model;

class GameOnClientModel implements Model
{
	@:observable var playerList:List<String> = [];
	@:observable var gameImageId:String = "";

	@:transition function nextStep(data)
	{return { gameImageId: data.gameImageId };
	}
	@:transition function setPlayerList(data) return { playerList: data };
}

typedef Test = {
	@:optional var id(default, never):String;
	@:optional var avatar(default, never):String;
}