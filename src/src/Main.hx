package;

import fp.ApplicationModel;
import fp.Layout;
import fp.component.landingpage.LandingPageComponent;
import fp.component.lobby.LobbyComponent;
import fp.component.takegamepics.TakeGamePicsComponent;
import fp.component.waitingforpics.WaitingForPicsComponent;
import haxe.Timer;
import js.Browser;

class Main
{
	static function main() new Main();

	var lobbyPage:LobbyComponent;

	public function new()
	{
		var appModel = new ApplicationModel();
		var layout = new Layout({});

		Browser.document.getElementById("fp_container").appendChild(layout.toElement());

		var landingPage = new LandingPageComponent(
			function(roomId) {
				lobbyPage.setRoomId(roomId);
				layout.setView(lobbyPage.view);
			}
		);

		lobbyPage = new LobbyComponent(
			layout.setView.bind(landingPage.view)
		);

		var waitingForPics = new WaitingForPicsComponent();
		var takeGamePics = new TakeGamePicsComponent();

		layout.setView(takeGamePics.view);
		takeGamePics.start();

		//Timer.delay(function() { appModel.setState(ApplicationState.TakeUserPicture); }, 2000);
	}
}