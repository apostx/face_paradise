package fp.component.landingpage;

import coconut.data.List;
import coconut.data.Model;
import io.colyseus.Client.RoomAvailable;

class LandingPageModel implements Model
{
	@:skipCheck @:observable var roomList:List<RoomAvailable> = null;

	@:transition function setList(list:Array<RoomAvailable>) return { roomList: List.fromArray(list) };
}
