package fp.component.lobby;

@:tink class LobbyComponent
{
	var closeLobbyRequest:Void->Void = _;

	public var view:LobbyView;
	public var model:LobbyModel;

	public function new ()
	{
		model = new LobbyModel();
		/*model.setList([
			new Player({avatar: "abc"}),
			new Player({avatar: "123"}),
			new Player({avatar: "qaz"})
		]);*/

		view = new LobbyView({
			//playerList: model.playerList,
			roomId: model.roomId,
			closeLobbyRequest: closeLobbyRequest
		});
	}

	public function setRoomId(roomId:String) { model.setRoomId(roomId); }
}