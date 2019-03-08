package fp.component.landingpage;

import coconut.data.List;
import coconut.data.Model;

class LandingPageModel implements Model
{
	@:observable var roomList:List<Room> = null;

	@:transition function setList(v) return { roomList: v };
}

typedef Room = {
	var id(default, never):String;
}