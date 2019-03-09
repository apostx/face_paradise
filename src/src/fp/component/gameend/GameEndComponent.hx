package fp.component.gameend;

@:tink class GameEndComponent
{
	public var view:GameEndView;

	public function new()
	{
		var model = new GameEndModel();
		model.setList([
			{ id: "1", avatar:"Room123"},
			{ id: "2", avatar:"Room456"},
			{ id: "3", avatar:"Room789"},
			{ id: "4", avatar:"RoomABC"},
			{ id: "5", avatar:"RoomXXX"}
		]);

		view = new GameEndView({
			playerList: model.playerList
		});
	}
}