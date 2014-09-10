package io.arkeus.tff.game.worldv2 {
	import io.arkeus.tff.assets.Resource;
	import io.arkeus.tiled.TiledLayer;
	import io.arkeus.tiled.TiledMap;
	import io.arkeus.tiled.TiledTileLayer;
	import io.axel.Ax;
	import io.axel.base.AxGroup;
	import io.axel.render.AxColor;

	public class WorldV2 extends AxGroup {
		public function WorldV2() {
			
		}
		
		public function load(map:TiledMap):void {
			for each (var layer:TiledLayer in map.layers.getVisibleLayers()) {
				if (layer is TiledTileLayer) {
					var tileLayer:TiledTileLayer = layer as TiledTileLayer;
					var worldLayer:WorldV2Layer = new WorldV2Layer;
					trace("DATA", tileLayer.name);
					trace(tileLayer.data);
					worldLayer.build(tileLayer.data, Resource.TILES_V2, map.tileWidth, map.tileHeight, 0, -1, -1, 2, 2);
					add(worldLayer);
				}
			}
			
			Ax.background = AxColor.fromHex(map.backgroundColor);
		}
	}
}
