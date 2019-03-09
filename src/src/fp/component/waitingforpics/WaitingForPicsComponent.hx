package fp.component.waitingforpics;

@:tink class WaitingForPicsComponent
{
	public var view:WaitingForPicsView;

	public function new()
	{
		var model = new WaitingForPicsModel();

		view = new WaitingForPicsView({
		});
	}
}