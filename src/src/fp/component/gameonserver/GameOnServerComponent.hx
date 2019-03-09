package fp.component.gameonserver;

import coconut.data.List;
import fp.service.WebSocketService;
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
			onGameEnd: onGameEnd
		});

		view = new GameOnServerView({
			currentStep: model.currentStep,
			remainingTimePercent: model.remainingTimePercent,
			currentImage: model.currentImage,
			playerList: model.playerList
		});

		voteConfig.bind(function(v){
			refreshPlayerList();
		});
	}

	public function nextStep(data:Dynamic)
	{
		model.nextStep(data);
		refreshPlayerList();
	}

	function refreshPlayerList()
	{
		var playerList:Array<String> = [];
		if (voteConfig.value != null && Reflect.hasField(voteConfig.value, model.observables.gameImageId))
		{
			model.setPlayerList(
				List.fromArray(
					Reflect.getProperty(WebSocketService.faceImageList, Reflect.getProperty(voteConfig.value, model.observables.gameImageId.value))
				)
			);
		}
	}
}