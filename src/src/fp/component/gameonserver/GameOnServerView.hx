package fp.component.gameonserver;

import coconut.ui.View;

class GameOnServerView extends View
{
	var names:Array<String> = ["A", "B", "C", "D", "E"];

	@:attribute var currentStep:UInt;
	@:attribute var currentImage:String;
	@:attribute var remainingTimePercent:Float;

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
					<for {name in names}>
						<div class="fp_game__player_photo">
							<div class="fp_game__player_name">$name</div>
						</div>
					</for>
				</div>
				<img class="fp_game__image" src=$currentImage />
			</div>
			<div class="fp_game__footer">
				<div class={"fp_game__footer_progress" + (remainingTimePercent > 0 ? " fp_game__footer_progress--in_progress" : " fp_game__footer_progress--empty")}>
				</div>
			</div>
		</div>
	';
}