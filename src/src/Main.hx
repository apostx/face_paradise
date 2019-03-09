package;

import fp.ApplicationModel;
import fp.Layout;
import fp.component.capture.CapturePageComponent;
import fp.component.gameend.GameEndComponent;
import fp.component.gameonclient.GameOnClientComponent;
import fp.component.gameonserver.GameOnServerComponent;
import fp.component.landingpage.LandingPageComponent;
import fp.component.lobby.LobbyComponent;
import fp.component.takegamepics.TakeGamePicsComponent;
import fp.component.waitingforgamestart.WaitingForGameStartComponent;
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
	var waitingForGameStart:WaitingForGameStartComponent;
	var gameOnServer:GameOnServerComponent;
	var gameOnClient:GameOnClientComponent;
	var gameEnd:GameEndComponent;

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
				capturePage.capture();
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
		takeGamePics = new TakeGamePicsComponent(
			function () {
				layout.setView(waitingForGameStart.view);
				Timer.delay(function() {
					layout.setView(gameOnServer.view);
					gameOnServer.start();
				}, 1000);
			}
		);
		waitingForGameStart = new WaitingForGameStartComponent();

		gameOnServer = new GameOnServerComponent(
			function () {
				layout.setView(gameEnd.view);
				Timer.delay(function() {
					layout.setView(landingPage.view);
				}, 5000);
			}
		);

		gameOnClient = new GameOnClientComponent(
			function(id) {
				trace(id);
			}
		);

		gameEnd = new GameEndComponent(
		);


		layout.setView(landingPage.view);
	}
}