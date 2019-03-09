package fp.component.gameonclient;

import coconut.data.List;
import fp.service.WebSocketService;
import tink.state.Observable;

@:tink class GameOnClientComponent
{
	var voteConfig:Observable<Dynamic> = _;
	var openVoteRequest:String->Void = _;

	public var model:GameOnClientModel;
	public var view:GameOnClientView;

	public function new()
	{
		model = new GameOnClientModel({});

		view = new GameOnClientView({
			playerList: model.playerList,
			openVoteRequest: openVoteRequest
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
		if (voteConfig.value != null && Reflect.hasField(voteConfig.value, model.observables.gameImageId.value))
		{
			model.setPlayerList(
				List.fromArray(
					Reflect.getProperty(WebSocketService.faceImageList, Reflect.getProperty(voteConfig.value, model.observables.gameImageId.value))
				)
			);
		}
	}
}