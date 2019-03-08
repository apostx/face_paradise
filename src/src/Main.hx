package;

import fp.ApplicationModel;
import fp.Layout;
import haxe.Timer;
import js.Browser;

class Main
{
	static function main() new Main();

	public function new ()
	{
		var appModel = new ApplicationModel();
		var layout = new Layout({
			appState: appModel.appState
		});

		Browser.document.getElementById("fp_container").appendChild(layout.toElement());

		Timer.delay(function() { appModel.setState(ApplicationState.TakeUserPicture); }, 2000);
	}
}