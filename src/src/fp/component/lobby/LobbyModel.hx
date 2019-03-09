package fp.component.lobby;

//import coconut.data.List;
import coconut.data.Model;
//import tink.pure.List;

class LobbyModel implements Model
{
	@:observable var roomId:String = "";
	//@:observable var playerList:List<Player> = null;

	//@:transition public function setList(v) return { playerList: v };

	@:transition public function setRoomId(v:String) return { roomId: v };
}
