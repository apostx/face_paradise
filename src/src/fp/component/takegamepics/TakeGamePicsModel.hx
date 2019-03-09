package fp.component.takegamepics;

import coconut.data.Model;
import fp.service.WebSocketService;
import haxe.Timer;

class TakeGamePicsModel implements Model
{
	@:constant private var timePerStep:UInt = 5000;

	@:external private var onPicsAreReady:Void->Void;

	@:skipCheck @:observable var levelData:Array<String> = [];
	@:observable var currentStep:UInt = 0;
	@:observable var stepStartTime:Float = 0;
	@:observable var remainingTimePercent:Float = 0;
	@:observable var isWaitingForPreloading:Bool = false;

	@:computed var currentImage:String = Reflect.getProperty(WebSocketService.gameImageList.value, levelData[currentStep]);
	@:skipCheck @:computed var pictureList:Array<String> = generatePictureList();

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
					onPicsAreReady,
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

	@:transition private function startNextStep()
	{
		Timer.delay(
			checkTime,
			200
		);

		return {
			currentStep: currentStep + 1,
			stepStartTime: Date.now().getTime(),
			remainingTimePercent: 0
		};
	}
}