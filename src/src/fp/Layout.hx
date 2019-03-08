package fp;

import coconut.ui.View;
import fp.ApplicationModel.ApplicationState;

class Layout extends View
{
	@:attribute var appState:ApplicationState;

	function render() '
		<div>
			<switch {appState}>
				<case {LandingPage}>
					<div>Hello</div>
				<case {TakeUserPicture}>
					<div>Take pic</div>
				<case {Lobby}>
					<div>Lobby</div>
				<case {MakePicturesServer}>
					<div>Make pic server</div>
				<case {MakePicturesClient}>
					<div>Make pic client</div>
			</switch>
		</div>
	';
}