package io.arkeus.tff.game.world {
	import org.axgl.Ax;
	import org.axgl.tilemap.AxTilemap;

	public class World extends AxTilemap {
		public function World() {
			super();
			Ax.background.hex = 0xffd0f4f7;
		}
	}
}
