package fp.component.capture;

class CapturePageComponent
{
	public var view:CapturePageView;

	public function new()
	{
		var model = new CapturePageModel();
		
		model.imagePath = "https://dfkfj8j276wwv.cloudfront.net/images/2f/33/ec/0d/2f33ec0d-cc56-4de3-a99e-ce602f02ebce/26375ab95642f59808539aee41d354a008b5ffc8175e30e3b83847257443da69337525aa06c25511a25125c89e3724e712517aeaf8969366a90f29e3bb0f2b48.jpeg";
		
		view = new CapturePageView({
			imagePath: model.imagePath,
			getMediaStream: model.getMediaStream,
			onPictureCaptured: model.onPictureCaptured
		});
		
		//model.startStream(cast view.video.toElement());
	}
}