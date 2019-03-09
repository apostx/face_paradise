package fp;

import coconut.data.Model;

class ApplicationModel implements Model
{
	@:observable var appType:ApplicationType = ApplicationType.Client;
	@:observable var appState:ApplicationState = ApplicationState.LandingPage;

	@:transition public function setState(v) return { appState: v };
	@:transition public function setType(v) return { appType: v };
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
