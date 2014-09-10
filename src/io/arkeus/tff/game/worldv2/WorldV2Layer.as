package io.arkeus.tff.game.worldv2 {
	import io.axel.Ax;
	import io.axel.tilemap.AxTilemap;

	public class WorldV2Layer extends AxTilemap {
		public function WorldV2Layer() {
		}
		
		public function initialize():void {
			Ax.camera.setBounds(0, 0, width, height);
		}
	}
}
