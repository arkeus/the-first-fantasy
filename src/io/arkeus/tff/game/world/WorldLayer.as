package io.arkeus.tff.game.world {
	import io.axel.Ax;
	import io.axel.tilemap.AxTilemap;

	public class WorldLayer extends AxTilemap {
		public function WorldLayer() {
		}
		
		public function initialize():void {
			Ax.camera.setBounds(0, 0, width, height);
		}
	}
}
