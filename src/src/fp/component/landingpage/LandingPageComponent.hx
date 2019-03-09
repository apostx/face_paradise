package fp.component.landingpage;

@:tink class LandingPageComponent
{
	var openRoomRequest:String->Void = _;

	public var view:LandingPageView;

	public function new()
	{
		var model = new LandingPageModel();
		model.setList([{id:"Room123"},{id:"Room456"},{id:"Room789"},{id:"RoomABC"}]);

		view = new LandingPageView({
			roomList: model.roomList,
			openRoomRequest: openRoomRequest
		});
	}
}