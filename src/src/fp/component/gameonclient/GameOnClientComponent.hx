package fp.component.gameonclient;

import coconut.data.List;
import fp.service.WebSocketService;
import tink.state.Observable;

@:tink class GameOnClientComponent
{
	var voteConfig:Observable<Dynamic> = _;
	var openVoteRequest:String->String->Bool->Void = _;

	public var model:GameOnClientModel;
	public var view:GameOnClientView;

	public function new()
	{
		model = new GameOnClientModel({});

		view = new GameOnClientView({
			playerList: model.playerList,
			gameImageId: model.gameImageId,
			openVoteRequest: function(gameImageId, faceImageId) { openVoteRequest(gameImageId, faceImageId, model.isLast); }
		});

		voteConfig.bind(function(v){
			refreshPlayerList();
		});
	}

	public function nextStep(data:Dynamic)
	{
		model.nextStep(data);
		refreshPlayerList();
		view.reset();
	}

	function refreshPlayerList()
	{
		var playerList:Array<String> = [];
		if (voteConfig.value != null && Reflect.hasField(voteConfig.value, model.observables.gameImageId.value))
		{
			var temp:Array<String> = Reflect.getProperty(voteConfig.value, model.observables.gameImageId.value);
			for (e in temp) playerList.push(Reflect.getProperty(WebSocketService.faceImageList, e));

			model.setPlayerList(
				List.fromArray(playerList)
			);
		}
	}
}