package fp.component.lobby;
import fp.service.WebSocketService;

@:tink class LobbyComponent
{
	var closeLobbyRequest:Void->Void = _;
	var gameStartRequest:Void->Void = _;

	public var view:LobbyView;
	public var model:LobbyModel;

	public function new ()
	{
		model = new LobbyModel();

		//WebSocketService.getPlayerList().handle(model.setList);

		view = new LobbyView({
			playerList: model.playerList,
			roomId: model.roomId,
			closeLobbyRequest: closeLobbyRequest,
			gameStartRequest: gameStartRequest
		});
	}

	public function setRoomId(roomId:String) { model.setRoomId(roomId); }
}