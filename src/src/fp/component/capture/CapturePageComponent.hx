package fp.component.capture;

@:tink class CapturePageComponent
{
	var openRoomRequest:Void->Void = _;

	public var view:CapturePageView;

	public function new()
	{
		var model = new CapturePageModel();

		view = new CapturePageView({
			onPictureCaptured: function(pic) {
				model.onPictureCaptured(pic);
				openRoomRequest();
			}
		});
	}

	public function capture() { view.capture(); }
}