package fp.component.waitingforgamestart;

@:tink class WaitingForGameStartComponent
{
	public var model:WaitingForGameStartModel;
	public var view:WaitingForGameStartView;

	public function new()
	{
		model = new WaitingForGameStartModel();

		view = new WaitingForGameStartView({
		});
	}
}