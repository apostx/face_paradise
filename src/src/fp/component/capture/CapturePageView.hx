package fp.component.capture;

import coconut.ui.View;
import fp.service.VideoStreamService;
import haxe.Timer;
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.Element;
import js.html.MediaStream;
import js.html.VideoElement;
import vdom.VNode;

using tink.CoreApi;

class CapturePageView extends View
{
	@:attribute var onPictureCaptured:String->Void;

	var video:VideoElement;

	function render() '
		<div style="width: absolute; right: 0px;">
			<video style="width: 100%; height: 100%;" autoplay></video>
		</div>
	';

	public function capture()
	{
		Timer.delay(function()
		{
			var picture = VideoStreamService.capturePicture();
			VideoStreamService.hideVideo();
			onPictureCaptured(picture);
		},
		3000);
	}
	
	override function afterInit(element:Element) VideoStreamService.showVideo();
}