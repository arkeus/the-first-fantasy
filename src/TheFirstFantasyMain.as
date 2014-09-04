package {
	import io.arkeus.tff.game.GameState;
	
	import io.axel.Ax;
	
	[SWF(width = "700", height = "420", backgroundColor = "#ffffff")]

	public class TheFirstFantasyMain extends Ax {
		public function TheFirstFantasyMain() {
			super(GameState, 0, 0, 1, 60);
		}
		
		override public function create():void {
			//Ax.unfocusedFramerate = 60;
		}
	}
}
