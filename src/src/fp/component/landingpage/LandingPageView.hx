package fp.component.landingpage;

import coconut.data.List;
import coconut.ui.View;
import io.colyseus.Client.RoomAvailable;

class LandingPageView extends View
{
	@:skipCheck @:attribute var roomList:List<RoomAvailable>;
	@:attribute var openRoomRequest:String->Void;
	@:attribute var updateRoomListRequest:Void->Void;
	@:attribute var createRoomRequest:Void->Void;

	function render() '
		<div>
			<div class="fp_room_list_container">
				<div class="fp_room_list_title">
					<div>Choose a game room</div>
					<div class="fp_button fp_button--refresh_room_list" onclick=$updateRoomListRequest><i class="fas fa-sync-alt"></i></div>
				</div>
				<ul class="fp_room_list">
					<if {roomList != null}>
						<for {room in roomList}>
							<li class="fp_room_entry" onclick={openRoomRequest(room.roomId)}>
								{room.roomId}
								<div class="fp_button fp_button--join_to_room">Join</div>
							</li>
						</for>
					</if>
				</ul>
			</div>
			<div class="fp_button fp_button--create_room" onclick=$createRoomRequest>Create Room</div>
		</div>
	';
}