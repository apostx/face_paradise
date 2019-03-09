package fp.component.takegamepics;

import coconut.ui.View;
import fp.service.VideoStreamService;
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.Element;
import js.html.MediaStream;
import js.html.VideoElement;

using tink.CoreApi;

class TakeGamePicsView extends View
{
	@:attribute var currentStep:UInt;
	@:attribute var currentImage:String;
	@:attribute var remainingTimePercent:Float;
	@:attribute var isWaitingForPreloading:Bool;

	@:skipCheck @:attribute var pictureList:Array<String>;
	
	public var video:VideoElement;

	function render() '
		<div>
			<if {!isWaitingForPreloading}>
				<div class="fp_take_pic__progress">
					<for {i in 0...5}>
						<div class = {"fp_take_pic__progress_step"
							+ (i > currentStep ? " fp_take_pic__progress_step--inactive" : "")
							+ (i == currentStep ? " fp_take_pic__progress_step--current" : "")
						}>
						<if { i < currentStep }>
							<i class="fas fa-check-circle fp_take_pic__progress_done"></i>
						<else>
							{ i + 1 }
						</if>
						</div>
					</for>
				</div>
				<div class="fp_take_pic__image" style="background-image: url($currentImage)">
				</div>
				<div class="fp_take_pic__my_photo">
				</div>
				<div class="fp_take_pic__footer">
					<div class={"fp_take_pic__footer_progress" + (remainingTimePercent > 0 ? " fp_take_pic__footer_progress--in_progress" : " fp_take_pic__footer_progress--empty")}>
					</div>
				</div>
			</if>
			<for {p in pictureList}>
				<div class="fp_is_hidden" style="background-image: url($p)"></div>
			</for>
		</div>
	';
}