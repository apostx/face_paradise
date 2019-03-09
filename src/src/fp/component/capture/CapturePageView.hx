package fp.component.capture;

import coconut.ui.View;
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
	@:attribute var imagePath:String;
	@:attribute var getMediaStream:Void->Future<MediaStream>;
	@:attribute var onPictureCaptured:String->Void;
	
	var video:VideoElement;

	function render() '
		<div style="width: absolute; right: 0px;">
			<img style="position: absolute; bottom: 0px; width: 100%; height: auto;" src={imagePath} />
			<video style="position: absolute; right: 0px; width: 33%; height: auto;" autoplay id="camera"></video>
		</div>
	';
	
	override function afterInit(element:Element)
	{
		getMediaStream().handle(function(mediaStream)
		{
			var video:VideoElement = cast element.lastElementChild;
			video.srcObject = mediaStream;
			
			Timer.delay(function()
			{
				var picture = capturePicture(video);
				onPictureCaptured(picture);
			},
			3000);
		});
	}
	
	function capturePicture(video:VideoElement):String
	{
		var canvas:CanvasElement = cast Browser.document.createElement('canvas');
		canvas.width = video.clientWidth;
		canvas.height = video.clientHeight;
		
		var context:CanvasRenderingContext2D = canvas.getContext2d();
		context.drawImage(video, 0, 0, canvas.width, canvas.height);
		
		return canvas.toDataURL();
	}
}