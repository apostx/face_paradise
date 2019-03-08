package;

import fp.ApplicationModel;
import fp.Layout;
import fp.component.landingpage.LandingPageComponent;
import haxe.Timer;
import js.Browser;

class Main
{
	static function main() new Main();

	public function new ()
	{
		var appModel = new ApplicationModel();
		var layout = new Layout({});

		Browser.document.getElementById("fp_container").appendChild(layout.toElement());

		var landingPage = new LandingPageComponent();

		layout.setView(landingPage.view);

		//Timer.delay(function() { appModel.setState(ApplicationState.TakeUserPicture); }, 2000);
	}
}