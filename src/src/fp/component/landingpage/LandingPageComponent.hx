package fp.component.landingpage;

import fp.service.WebSocketService;

@:tink class LandingPageComponent
{
	var openRoomRequest:String->Void = _;
	var onRoomCreated:Void->Void = _;

	public var view:LandingPageView;
	public var model:LandingPageModel;

	public function new()
	{
		model = new LandingPageModel();

		view = new LandingPageView({
			roomList: model.roomList,
			openRoomRequest: openRoomRequest,
			updateRoomListRequest: updateRoomList,
			createRoomRequest: function() {
				WebSocketService.createRoom();
				onRoomCreated();
				openRoomRequest("asd");
			}
		});

		updateRoomList();
	}

	function updateRoomList()
	{
		WebSocketService.getRoomList().handle(model.setList);
	}
}