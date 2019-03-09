package fp.component.landingpage;

import coconut.data.List;
import coconut.ui.View;
import fp.component.landingpage.LandingPageModel.Room;

class LandingPageView extends View
{
	@:attribute var roomList:List<Room>;
	@:attribute var openRoomRequest:String->Void;

	function render() '
		<div>
			<div class="fp_room_list_container">
				<div class="fp_room_list_title">
					<div>Choose a game room</div>
					<div class="fp_button fp_button--refresh_room_list"><i class="fas fa-sync-alt"></i></div>
				</div>
				<ul class="fp_room_list">
					<if {roomList != null}>
						<for {room in roomList}>
							<li class="fp_room_entry" onclick={openRoomRequest(room.id)}>
								{room.id}
								<div class="fp_button fp_button--join_to_room">Join</div>
							</li>
						</for>
					</if>
				</ul>
			</div>
			<div class="fp_button fp_button--create_room">Create Room</div>
		</div>
	';
}