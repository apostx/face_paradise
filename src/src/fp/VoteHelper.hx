package fp;
import fp.service.WebSocketService;

class VoteHelper
{
	public static var votes:Array<{gameImageId:String, faceImageId:String}> = [];

	static function reset()
	{
		votes = [];
	}

	public static function vote(gameImageId, faceImageId)
	{
		votes.push({
			gameImageId: gameImageId,
			faceImageId: faceImageId
		});
	}

	public static function sendVotes()
	{
		WebSocketService.voteUpload(votes);
		reset();
	}
}