package fp.component.takegamepics;
import fp.service.WebSocketService;

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
			currentImage: model.currentImage,
			isWaitingForPreloading: model.isWaitingForPreloading,
			pictureList: model.pictureList
		});
	}

	public function start(data:Array<String>) { model.startRequest(data); }
}