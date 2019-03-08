package fp.component.landingpage;

class LandingPageComponent
{
	public var view:LandingPageView;

	public function new ()
	{
		var model = new LandingPageModel();
		model.setList([{id:"Room123"},{id:"Room456"},{id:"Room789"},{id:"RoomABC"}]);

		view = new LandingPageView({ roomList: model.roomList });
	}
}