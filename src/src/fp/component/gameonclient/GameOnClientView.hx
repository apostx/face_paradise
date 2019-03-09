package fp.component.gameonclient;

import coconut.data.List;
import coconut.ui.View;
import fp.component.gameonclient.GameOnClientModel.Test;

class GameOnClientView extends View
{
	@:attribute var playerList:List<String>;
	@:attribute var gameImageId:String;

	@:attribute var openVoteRequest:String->String->Void;
	@:state var isAlreadyVoted:Bool = false;

	function render() '
		<div class={"fp_player_list_container" + (isAlreadyVoted ? " fp_player_list_container--voted" : "") }>
			<div class="fp_room_list_title">
			<div>Who\'s reaction is true?</div>
			</div>
			<ul class="fp_room_list">
				<if {playerList != null}>
					<for {i in 0...playerList.length}>
						<li class="fp_room_entry" onclick={onClick(playerList.toArray()[i])}>
							<div class="fp_player" style="background-image: ${getImage(i)}"></div>
						</li>
					</for>
				</if>
			</ul>
		</div>
	';

	function onClick(id)
	{
		isAlreadyVoted = true;
		openVoteRequest(gameImageId, id);
	};

	function getImage(index)
	{
		return "url(" + playerList.toArray()[index] + ")";
	}

	public function reset() isAlreadyVoted = false;
}