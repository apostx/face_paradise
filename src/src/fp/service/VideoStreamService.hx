package fp.service;

import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.MediaStream;
import js.html.VideoElement;
import tink.CoreApi.Future;

class VideoStreamService 
{
	static private var canvas:CanvasElement = cast Browser.document.createElement('canvas');
	
	static public function getVideoElement():VideoElement
	{
		return cast Browser.document.getElementById("fp_video");
	}
	
	static public function showVideo():Void getVideoElement().hidden = false;
	static public function hideVideo():Void getVideoElement().hidden = true;
	
	static public function capturePicture():String
    {
		var video = getVideoElement();
		
        canvas.width = video.clientWidth;
        canvas.height = video.clientHeight;
        
        var context:CanvasRenderingContext2D = canvas.getContext2d();
        context.drawImage(video, 0, 0, canvas.width, canvas.height);
        
        return canvas.toDataURL();
    }
}