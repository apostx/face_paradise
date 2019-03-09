package fp.component.gameonclient;

import coconut.data.List;
import coconut.data.Model;

class GameOnClientModel implements Model
{
	@:skipCheck @:external private var voteConfig:Dynamic;

	@:skipCheck @:computed var playerList:Array<String> = calculatePlayers();
	function calculatePlayers()
	{
		if (voteConfig != null && Reflect.hasField(voteConfig, gameImageId)) return Reflect.getProperty(voteConfig, gameImageId);

		return null;
	}

	@:observable private var gameImageId:String = "";
	@:transition function nextStep(data) return { gameImageId: data.gameImageId };
}

typedef Test = {
	@:optional var id(default, never):String;
	@:optional var avatar(default, never):String;
}