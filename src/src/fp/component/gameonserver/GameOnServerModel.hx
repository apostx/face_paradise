package fp.component.gameonserver;

import coconut.data.Model;
import haxe.Timer;
import tink.state.Observable;

class GameOnServerModel implements Model
{
	@:constant private var timePerStep:UInt = 3000;

	@:skipCheck @:external private var voteConfig:Array<Dynamic>;
	@:external private var onGameEnd:Void->Void;

	@:observable var currentStep:Int = -1;
	@:observable var stepStartTime:Float = 0;
	@:observable var remainingTimePercent:Float = 0;
	@:observable var currentImage:String = "";
	@:skipCheck @:observable var currentRoundInfo:Array<String> = [];

	@:transition public function nextStep(data:Dynamic)
	{
		Timer.delay(
			checkTime,
			100
		);

		return {
			stepStartTime: Date.now().getTime(),
			currentStep: currentStep + 1,
			remainingTimePercent: 0,
			currentRoundInfo: Reflect.getProperty(voteConfig[currentStep].value, data.gameImageId)
		};
	}

	@:transition private function checkTime()
	{
		var newRemainingTime = Date.now().getTime() - stepStartTime;
		if (newRemainingTime >= timePerStep)
		{
			return { remainingTimePercent: 100 };
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
}