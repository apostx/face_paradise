package fp.component.lobby;

import coconut.data.Model;
import fp.component.gameonclient.GameOnClientModel.Test;

class LobbyModel implements Model
{
	@:observable var roomId:String = null;
	@:skipCheck @:observable var playerList:Array<Test> = null;

	@:transition public function setList(v) return { playerList: v };

	@:transition public function setRoomId(v:String) return { roomId: v };
}
