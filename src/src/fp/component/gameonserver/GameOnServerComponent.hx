package fp.component.gameonserver;

@:tink class GameOnServerComponent
{
	var onGameEnd:Void->Void = _;

	public var model:GameOnServerModel;
	public var view:GameOnServerView;

	public function new()
	{
		model = new GameOnServerModel({
			onGameEnd: onGameEnd
		});

		view = new GameOnServerView({
			currentStep: model.currentStep,
			remainingTimePercent: model.remainingTimePercent,
			currentImage: model.currentImage
		});
	}

	public function start() { model.start(); }
}