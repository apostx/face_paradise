package fp.component.gameonclient;

import tink.state.Observable;

@:tink class GameOnClientComponent
{
	var voteConfig:Observable<Dynamic> = _;
	var openVoteRequest:String->Void = _;

	public var model:GameOnClientModel;
	public var view:GameOnClientView;

	public function new()
	{
		model = new GameOnClientModel({
			voteConfig: voteConfig
		});

		view = new GameOnClientView({
			playerList: model.playerList,
			openVoteRequest: openVoteRequest
		});
	}

	public function nextStep(data:Dynamic) { model.nextStep(data); }
}