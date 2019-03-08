package fp.component.landingpage;

import coconut.data.List;
import coconut.ui.View;
import fp.component.landingpage.LandingPageModel.Room;

class LandingPageView extends View
{
	@:attribute var roomList:List<Room>;

	function render() '
		<div>
			<ul class="fp_room_list">
				<for {room in roomList}>
					<li class="fp_room_entry">
						{room.id}
						<div class="fp_join_to_room_button">Join</div>
					</li>
				</for>
			</ul>
		</div>
	';
}