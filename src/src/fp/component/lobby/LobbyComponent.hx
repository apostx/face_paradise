package fp.component.lobby;
import fp.ApplicationModel.ApplicationType;
import fp.component.gameonclient.GameOnClientModel.Test;
import fp.service.WebSocketService;
import tink.state.Observable;

@:tink class LobbyComponent
{
	var appType:Observable<ApplicationType> = _;
	var closeLobbyRequest:Void->Void = _;

	public var view:LobbyView;
	public var model:LobbyModel;

	public function new ()
	{
		model = new LobbyModel();

		WebSocketService.userList.observe().bind(function(list:Array<String>) {
			if (list == null) return;

			var newList:Array<Test> = [];
			for (user in list)
			{
				var user = Reflect.getProperty(WebSocketService.userDataList, user);
				if (user != null)
				{
					var avatarId = user.avatarId;
					var avatar = Reflect.getProperty(WebSocketService.faceImageList, avatarId);

					newList.push({avatar: avatar});
				}
			}

			model.setList(newList);
		});

		view = new LobbyView(
		{
			appType: appType,
			playerList: model.playerList,
			closeLobbyRequest: closeLobbyRequest,
			gameStartRequest: WebSocketService.startGame,
			custromRoomId: WebSocketService.getCustomRoomId(model.roomId)
		});
	}

	public function setRoomId(roomId:String) { model.setRoomId(roomId); }
}