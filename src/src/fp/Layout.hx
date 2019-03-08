package fp;

import coconut.ui.Renderable;
import coconut.ui.View;

class Layout extends View
{
	@:state var currentView:View = null;

	function render() '
		<div>{currentView != null ? currentView : ""}</div>
	';

	public function setView(r) currentView = r;
}