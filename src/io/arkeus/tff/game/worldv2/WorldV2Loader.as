package io.arkeus.tff.game.worldv2 {
	import io.arkeus.tiled.TiledReader;

	public class WorldV2Loader {
		private var map:Class;
		
		public function WorldV2Loader(map:Class) {
			this.map = map;
		}
		
		public function build():WorldV2 {
			var world:WorldV2 = new WorldV2;
			world.load(new TiledReader().loadFromEmbedded(map));
			return world;
		}
	}
}
