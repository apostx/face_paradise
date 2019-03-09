package fp.component.gameonserver;

import coconut.data.List;
import coconut.ui.View;
import fp.service.WebSocketService;

class GameOnServerView extends View
{
	var names:Array<String> = ["A", "B", "C", "D", "E"];

	@:attribute var currentStep:UInt;
	@:attribute var gameImageId:String;
	@:attribute var remainingTimePercent:Float;
	@:skipCheck @:attribute var playerList:List<String>;

	function render() '
		<div>
			<div class="fp_game_progress">
				<for {i in 0...10}>
					<div class = {"fp_game_progress__step"
						+ (i > currentStep ? " fp_game_progress__step--inactive" : "")
						+ (i == currentStep ? " fp_game_progress__step--current" : "")
					}>
					<if { i < currentStep }>
						<i class="fas fa-check-circle fp_game_progress__done"></i>
					<else>
						{ i + 1 }
					</if>
					</div>
				</for>
			</div>
			<div class="fp_game_area">
				<div class="fp_game__player_list">
					<for {i in 0...playerList.length}>
						<div class="fp_game__player_photo">
							<div class="fp_player" style="background-image: ${getImage(i)}"></div>
						<div class="fp_game__player_name">${names[i]}</div>
						</div>
					</for>
				</div>
				<img class="fp_game__image" src=${Reflect.getProperty(WebSocketService.faceImageList, gameImageId)} />
			</div>
			<div class="fp_game__footer">
				<div class={"fp_game__footer_progress" + (remainingTimePercent > 0 ? " fp_game__footer_progress--in_progress" : " fp_game__footer_progress--empty")}>
				</div>
			</div>
		</div>
	';

	function getImage(index)
	{
		return "url(" + playerList.toArray()[index] + ")";
	}
}