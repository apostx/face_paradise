package fp.component.gameend;

import coconut.ui.View;
import fp.component.gameonclient.GameOnClientModel.Test;

class GameEndView extends View
{
	@:skipCheck @:attribute var playerList:Array<Test>;

	function render() '
		<div class="fp_player_list_container">
			<div class="fp_room_list_title">
			<div>List of Fame</div>
			</div>
			<ul class="fp_room_list">
				<if {playerList != null}>
					<for {player in playerList}>
						<li class="fp_room_entry fp_player--no_user_action">
							{player.avatar}
						</li>
					</for>
				</if>
			</ul>
		</div>
	';
}