package fp.component.gameonclient;

import tink.state.Observable;

@:tink class GameOnClientComponent
{
	var voteConfig:Observable<Array<Dynamic>> = _;
	var openVoteRequest:String->Void = _;

	public var view:GameOnClientView;

	public function new()
	{
		var model = new GameOnClientModel();
		model.setList([
			{ id: "1", avatar:"Room123"},
			{ id: "2", avatar:"Room456"},
			{ id: "3", avatar:"Room789"},
			{ id: "4", avatar:"RoomABC"},
			{ id: "5", avatar:"RoomXXX"}
		]);

		view = new GameOnClientView({
			playerList: model.playerList,
			openVoteRequest: openVoteRequest
		});
	}

	public function nextStep(data:Dynamic) {  }
}