package fp.service;

import io.colyseus.Client;
import io.colyseus.Room;
import tink.state.State;

using tink.CoreApi;

class WebSocketService
{
	static var client:Client;
	static public var room:Room;

	static var showStartSignalTrigger:SignalTrigger<Noise> = new SignalTrigger<Noise>();
	static public var showStartSignal:Signal<Noise> = showStartSignalTrigger.asSignal();

	static public var mainState:State<String> = new State<String>(null);
	static public var voteRound:State<Int> = new State<Int>(0);
	static public var playerCount:State<Int> = new State<Int>(0);
	static public var maxVoteRound:State<Int> = new State<Int>(0);

	static public var gameImageList:Array<String> = new Array<String>();
	static public var faceImageList:Array<String> = new Array<String>();

	static public function connect():Future<Noise>
	{
		var t = Future.trigger();

		client = new Client("wss://faceparadise.herokuapp.com");

		client.onOpen = function() {
			t.trigger(Noise);
		};

		return t;
	}

	static public function getRoomList():Future<Array<RoomAvailable>>
	{
		var t = Future.trigger();

		client.getAvailableRooms("game", function(roomList: Array<RoomAvailable>, ?opt:String)
		{
			t.trigger(roomList);
		});

		return t;
	}

	static public function createRoom():Future<String>
	{
		var t = Future.trigger();

		room = client.join("game", ["create" => "true"]);
		room.onMessage = onMessage;
		room.onStateChange = onStateChange;

		room.onJoin = function () {
			t.trigger(room.id);
		};

		return t;
	}

	static public function joinRoom(roomId:String):Future<String>
	{
		var t = Future.trigger();

		room = client.join(roomId);
		room.onMessage = onMessage;
		room.onStateChange = onStateChange;
		room.onJoin = function () {
			t.trigger(room.id);
		};

		return t;
	}

	static function onMessage(message:{event:String, data:Dynamic})
	{
		switch(message.event)
		{
			case "displayStart":
				showStartSignalTrigger.trigger(Noise);
			default:
		}
	}

	static function onStateChange(state:Dynamic)
	{
		updateState(state.mainState, mainState);
		updateState(state.voteRound, voteRound);
		updateState(state.playerCount, playerCount);
		updateState(state.maxVoteRound, maxVoteRound);

		gameImageList = updateValue(state.gameImageList, gameImageList);
		faceImageList = updateValue(state.faceImageList, faceImageList);
	}

	static function updateState<T>(value:T, state:State<T>):Void
	{
		if (value != null) state.set(value);
	}

	static function updateValue<T>(newValue:T, value:T):T
	{
		return newValue != null ? newValue : value;
	}

	// #1
	static public function avatarUpload(image:String):Void
	{
		room.send({
			event: "avatarUpload",
			data: image
		});
	}

	// #2
	static public function start():Void
	{
		room.send({
			event: "start"
		});
	}

	// #3
	static public function faceImagesUpload(list:Array<{gameImageId:Int, faceImage:String}>):Void
	{
		room.send({
			event: "faceImagesUpload",
			data: list
		});
	}

	/*static public function voteUpload(image:String):Void
	{
		room.send({
			event: "avatarUpload",
			data: uploadAvatar
		});
	}*/
}