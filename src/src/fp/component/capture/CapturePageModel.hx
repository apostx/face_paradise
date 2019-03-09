package fp.component.capture;

import coconut.data.Model;
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.MediaStream;
import js.html.VideoElement;

using tink.CoreApi;

class CapturePageModel implements Model
{
	@:editable var isVisible:Bool = false;
	@:editable var imagePath:String = "";
	
	/*public function startStream():Void
	{
		var canvas:CanvasElement = cast Browser.document.getElementById('canvas');
		var player:VideoElement = cast Browser.document.getElementById("camera");
		
		getStream().handle(function(mediaStream)
		{
			player.srcObject = mediaStream;
		});
	}*/
	
	public function makeCapture():Void
	{
		var canvas:CanvasElement = cast Browser.document.getElementById('canvas');
		var player:VideoElement = cast Browser.document.getElementById("camera");
		
		var context:CanvasRenderingContext2D = canvas.getContext2d();
		context.drawImage(player, 0, 0, canvas.width, canvas.height);
	}
	
	public function getMediaStream():Future<MediaStream>
	{
		var t = Future.trigger();
		
		var onComplete = function(mediaStream)
		{
			t.trigger(mediaStream);
		}
		
		untyped __js__('navigator.mediaDevices.getUserMedia({video: true}).then({0})', onComplete);
		
		return t.asFuture();
	}
	
	public function onPictureCaptured(picture:String):Void
	{
		imagePath = picture;
	}
}
