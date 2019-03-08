package fp;

import coconut.data.Model;

class ApplicationModel implements Model
{
	@:observable var appType:ApplicationType = ApplicationType.Server;
	@:observable var appState:ApplicationState = ApplicationState.LandingPage;

	@:transition public function setState(s) return { appState: s };
}

enum ApplicationType
{
	Server;
	Client;
}

@:enum abstract ApplicationState(String) from String to String
{
	var LandingPage = "landingPage";
	var TakeUserPicture = "takeUserPicture";
	var Lobby = "lobby";
	var MakePicturesServer = "makePicturesServer";
	var MakePicturesClient = "makePicturesClient";
}
