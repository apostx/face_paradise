package fp.service;

import io.colyseus.Client;
import io.colyseus.Room;
import tink.state.State;

using tink.CoreApi;

class WebSocketService 
{
	static var client:Client;
	static var room:Room;
	
	static public function connect():Future<Noise>
	{
		var t = Future.trigger();
		
		client = new Client("wss://faceparadise.herokuapp.com");
		
		client.onOpen.add(function() {
			t.trigger(Noise);
		});
		
		return t;
	}
	
	static public function getRoomList(roomId:String):Future<Array<RoomAvailable>>
	{
		var t = Future.trigger();
		
		room = client.getAvailableRooms(function(roomList: Array<RoomAvailable>, ?opt:String)
		{
			t.trigger(roomList);
		});
		
		return t;
	}
	
	static public function joinRoom(roomId:String):Void
	{
		room = client.join(roomId);
		room.onMessage.add(onMessage);
	}
	
	static function onMessage(message)
	{

	}
}