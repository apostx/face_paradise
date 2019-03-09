package fp.component.landingpage;

import fp.service.WebSocketService;
import haxe.Timer;

@:tink class LandingPageComponent
{
	var openRoomRequest:String->Bool->Void = _;
	var onRoomCreated:Void->Void = _;

	public var view:LandingPageView;
	public var model:LandingPageModel;

	public function new()
	{
		model = new LandingPageModel();

		view = new LandingPageView({
			roomList: model.roomList,
			openRoomRequest: function(id, isServer) {
				WebSocketService.joinRoom(id).handle(openRoomRequest.bind(id, isServer));
			},
			updateRoomListRequest: updateRoomList,
			createRoomRequest: function() {
				WebSocketService.createRoom().handle(function(){
					onRoomCreated();
					openRoomRequest(WebSocketService.room.id, true);
				});
			}
		});

		updateRoomList();
	}

	function updateRoomList()
	{
		WebSocketService.getRoomList().handle(model.setList);
	}
}