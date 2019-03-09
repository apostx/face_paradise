package;

import fp.ApplicationModel;
import fp.Layout;
import fp.component.capture.CapturePageComponent;
import fp.component.landingpage.LandingPageComponent;
import fp.component.lobby.LobbyComponent;
import fp.component.takegamepics.TakeGamePicsComponent;
import fp.component.waitingforpics.WaitingForPicsComponent;
import fp.service.WebSocketService;
import haxe.Timer;
import js.Browser;

class Main
{
	static function main() new Main();

	var lobbyPage:LobbyComponent;
	var capturePage:CapturePageComponent;
	var waitingForPics:WaitingForPicsComponent;
	var takeGamePics:TakeGamePicsComponent;

	public function new()
	{
		WebSocketService.connect().handle(onConnect);
	}
	
	function onConnect()
	{
		var appModel = new ApplicationModel();
		var layout = new Layout({});

		Browser.document.getElementById("fp_container").appendChild(layout.toElement());

		var landingPage = new LandingPageComponent(
			function(roomId) {
				lobbyPage.setRoomId(roomId);
				layout.setView(capturePage.view);
			}
		);

		capturePage = new CapturePageComponent(
			function() {
				layout.setView(lobbyPage.view);
			}
		);

		lobbyPage = new LobbyComponent(
			layout.setView.bind(landingPage.view),
			function() {
				layout.setView(takeGamePics.view);
				takeGamePics.start();
			}
		);

		waitingForPics = new WaitingForPicsComponent();
		takeGamePics = new TakeGamePicsComponent();


		layout.setView(landingPage.view);

		//Timer.delay(function() { appModel.setState(ApplicationState.TakeUserPicture); }, 2000);
	}
}