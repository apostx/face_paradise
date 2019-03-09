package fp.component.lobby;

import coconut.ui.View;
import fp.ApplicationModel.ApplicationType;
import fp.component.gameonclient.GameOnClientModel.Test;
import io.colyseus.Room;

class LobbyView extends View
{
	@:attribute var appType:ApplicationType;
	@:attribute var closeLobbyRequest:Void->Void;
	@:attribute var gameStartRequest:Void->Void;
	@:skipCheck @:attribute var playerList:Array<Test>;
	@:skipCheck @:attribute var custromRoomId:String;

	function render() '
		<div>
			<div class="fp_lobby_container">
				<div class="fp_button fp_button--exit_from_room" onclick=$closeLobbyRequest><i class="fas fa-times-circle"></i></div>
				<div class="fp_player_list_title">
					Users in $custromRoomId
				</div>
				<div class="fp_player_list">
					<if {playerList != null}>
						<for {player in playerList}>
							<div class="fp_player" style="background-image: ${getImage(player)}"></div>
						</for>
					</if>
				</div>
			</div>
			<if {appType == ApplicationType.Server}>
				<div class="fp_button fp_button--primary" onclick=$gameStartRequest>Start Game</div>
			</if>
		</div>
	';

	function getImage(p:Test)
	{
		return "url(" + p.avatar + ")";
	}
}