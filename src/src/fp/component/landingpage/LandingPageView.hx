package fp.component.landingpage;

import coconut.data.List;
import coconut.ui.View;
import io.colyseus.Client.RoomAvailable;

class LandingPageView extends View
{
	@:skipCheck @:attribute var roomList:List<RoomAvailable>;
	@:attribute var openRoomRequest:String->Bool->Void;
	@:attribute var updateRoomListRequest:Void->Void;
	@:attribute var createRoomRequest:Void->Void;
	@:attribute var getCustomRoomId:String->String;

	function render() '
		<div>
			<div class="fp_room_list_title">
				<div class="fp_title"><i class="fas fa-crosshairs"></i> Choose a Room</div>
				<div class="fp_button fp_button--refresh_room_list" onclick=$updateRoomListRequest><i class="fas fa-sync-alt"></i></div>
			</div>
			<div class="fp_room_list_container">
				<ul class="fp_room_list">
					<if {roomList != null}>
						<for {room in roomList}>
							<li class="fp_room_entry" onclick={openRoomRequest(room.roomId, false)}>
								<div class="fp_room_name">{getCustomRoomId(room.roomId)}</div>
								<div class="fp_button fp_button--join_to_room">Join <i class="fas fa-sign-in-alt"></i></div>
							</li>
						</for>
					</if>
				</ul>
			</div>
			<div class="fp_button fp_button--primary" onclick=$createRoomRequest><i class="fas fa-plus-circle fp_left_icon"></i>Create Room</div>
			<div class="fp_logo"><img class="fp_logo__img" src="/asset/img/logo.png" /></div>
		</div>
	';
}