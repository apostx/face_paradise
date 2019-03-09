package fp.component.gameonserver;
import tink.state.Observable;

@:tink class GameOnServerComponent
{
	var voteConfig:Observable<Dynamic> = _;
	var onGameEnd:Void->Void = _;

	public var model:GameOnServerModel;
	public var view:GameOnServerView;

	public function new()
	{
		model = new GameOnServerModel({
			voteConfig: voteConfig,
			onGameEnd: onGameEnd
		});

		view = new GameOnServerView({
			currentStep: model.currentStep,
			remainingTimePercent: model.remainingTimePercent,
			currentImage: model.currentImage,
			playerList: model.playerList
		});
	}

	public function nextStep(data:Dynamic) { model.nextStep(data); }
}