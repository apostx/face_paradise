package fp.component.takegamepics;

import coconut.data.Model;
import fp.service.VideoStreamService;
import fp.service.WebSocketService;
import haxe.Timer;
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.VideoElement;

class TakeGamePicsModel implements Model
{
	@:constant private var timePerStep:UInt = 5000;

	@:external private var onPicsAreReady:Void->Void;

	@:skipCheck @:observable var levelData:Array<String> = [];
	@:observable var currentStep:UInt = 0;
	@:observable var stepStartTime:Float = 0;
	@:observable var remainingTimePercent:Float = 0;
	@:observable var isWaitingForPreloading:Bool = false;

	@:computed var currentImage:String = Reflect.getProperty(WebSocketService.gameImageList.value, currentImageId);
	@:computed var currentImageId:String = levelData[currentStep];
	@:skipCheck @:computed var pictureList:Array<String> = generatePictureList();
	
	@:skipCheck @:editable var capturedPictureList:Array<Dynamic> = null;

	function generatePictureList()
	{
		var a:Array<String> = [];
		for (i in 0...levelData.length)
		{
			a.push(Reflect.getProperty(WebSocketService.gameImageList.value, levelData[i]));
		}

		return a;
	}

	@:transition public function startRequest(data:Array<String>)
	{
		Timer.delay(
			start,
			3000
		);

		return {
			isWaitingForPreloading: true,
			levelData: data,
		};
	}


	@:transition public function start()
	{
		Timer.delay(
			checkTime,
			100
		);
		
		VideoStreamService.showVideo();
		capturedPictureList = new Array<Dynamic>();

		return {
			isWaitingForPreloading: false,
			stepStartTime: Date.now().getTime(),
			currentStep: 0,
			remainingTimePercent: 0
		};
	}

	@:transition private function checkTime()
	{
		var newRemainingTime = Date.now().getTime() - stepStartTime;
		if (newRemainingTime >= timePerStep)
		{
			if (currentStep < 4)
			{
				Timer.delay(
					startNextStep,
					1000
				);

				return return { remainingTimePercent: 100 };
			}
			else
			{
				Timer.delay(
					onPicsAreReady2,
					1000
				);
				return { currentStep: currentStep + 1, remainingTimePercent: 100 };
			}
		}
		else
		{
			Timer.delay(
				checkTime,
				200
			);
			return { remainingTimePercent: newRemainingTime / timePerStep * 100 };
		}
	}
	
	private function onPicsAreReady2()
	{
		saveCapturedPicture();
		VideoStreamService.hideVideo();
		WebSocketService.faceImagesUpload(cast capturedPictureList);
		onPicsAreReady();
	}

	@:transition private function startNextStep()
	{
		Timer.delay(
			checkTime,
			200
		);
		
		saveCapturedPicture();

		return {
			currentStep: currentStep + 1,
			stepStartTime: Date.now().getTime(),
			remainingTimePercent: 0
		};
	}
	
	function saveCapturedPicture()
	{
		capturedPictureList.push({
			gameImageId: currentImageId,
			faceImage: VideoStreamService.capturePicture()
		});
	}
}