package fp.component.gameonserver;

import coconut.data.List;
import coconut.data.Model;
import haxe.Timer;
import tink.state.Observable;

class GameOnServerModel implements Model
{
	@:constant private var timePerStep:UInt = 3000;

	@:observable var playerList:List<String> = [];
	@:observable var gameImageId:String = "";

	@:external private var onGameEnd:Void->Void;

	@:observable var currentStep:Int = -1;
	@:observable var stepStartTime:Float = 0;
	@:observable var remainingTimePercent:Float = 0;
	@:observable var currentImage:String = "";

	@:transition function setPlayerList(data) return { playerList: data };

	@:transition function nextStep(data)
	{
		Timer.delay(
			checkTime,
			100
		);

		return {
			gameImageId: data.gameImageId,
			stepStartTime: Date.now().getTime(),
			currentStep: currentStep + 1,
			remainingTimePercent: 0
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