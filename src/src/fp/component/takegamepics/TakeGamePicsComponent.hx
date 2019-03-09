package fp.component.takegamepics;

@:tink class TakeGamePicsComponent
{
	var onPicsAreReady:Void->Void = _;

	public var model:TakeGamePicsModel;
	public var view:TakeGamePicsView;

	public function new()
	{
		model = new TakeGamePicsModel({
			onPicsAreReady: onPicsAreReady
		});

		view = new TakeGamePicsView({
			currentStep: model.currentStep,
			remainingTimePercent: model.remainingTimePercent,
			currentImage: model.currentImage
		});
	}

	public function start() { model.start(); }
}