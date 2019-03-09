package fp.component.gameonclient;

import coconut.ui.View;
import fp.component.gameonclient.GameOnClientModel.Test;

class GameOnClientView extends View
{
	@:skipCheck @:attribute var playerList:Array<Test>;

	@:attribute var openVoteRequest:String->Void;
	@:state var isAlreadyVoted:Bool = false;

	function render() '
		<div class={"fp_player_list_container" + (isAlreadyVoted ? " fp_player_list_container--voted" : "") }>
			<div class="fp_room_list_title">
			<div>Who\'s reaction is true?</div>
			</div>
			<ul class="fp_room_list">
				<if {playerList != null}>
					<for {player in playerList}>
						<li class="fp_room_entry" onclick={onClick(player.id)}>
							{player.avatar}
						</li>
					</for>
				</if>
			</ul>
		</div>
	';

	function onClick(id)
	{
		isAlreadyVoted = true;
		openVoteRequest(id);
	};
}