package io.arkeus.tff.game.world {
	import io.arkeus.tff.assets.Resource;
	import io.arkeus.tiled.TiledLayer;
	import io.arkeus.tiled.TiledMap;
	import io.arkeus.tiled.TiledTileLayer;
	import io.axel.Ax;
	import io.axel.AxU;
	import io.axel.base.AxEntity;
	import io.axel.base.AxGroup;
	import io.axel.collision.AxCollider;
	import io.axel.collision.AxGroupCollider;
	import io.axel.render.AxColor;
	import io.axel.tilemap.AxTile;

	public class World extends AxGroup {
		public var collider:AxCollider;

		private var collision:Vector.<CollisionDescriptor>;

		public function World(collision:Vector.<CollisionDescriptor>) {
			this.collision = collision;
		}

		public function load(map:TiledMap):void {
			var width:uint = 0, height:uint = 0;
			for each (var layer:TiledLayer in map.layers.getVisibleLayers()) {
				if (layer is TiledTileLayer) {
					var tileLayer:TiledTileLayer = layer as TiledTileLayer;
					var worldLayer:WorldLayer = new WorldLayer;
					worldLayer.build(tileLayer.data, Resource.TILES_V2, map.tileWidth, map.tileHeight, uint.MAX_VALUE, -1, -1, 2, 2);
					add(worldLayer);
					width = Math.max(width, worldLayer.width);
					height = Math.max(height, worldLayer.height);
					
					// Only apply logic to "main" layer
					if (layer.name != "main") {
						continue;
					}

					for each (var cd:CollisionDescriptor in collision) {
						var tile:AxTile = worldLayer.getTileAtSpritesheet(cd.x, cd.y);
						tile.collision = cd.collision;
						if (tile.collision == AxEntity.UP) {
							tile.oneWay = true;
						}
						if (cd.slope != null) {
							trace("sloping tile at", tile.index, "to", cd.slope);
							tile.setProperty("slope", cd.slope[0]);
							tile.setProperty("intercept", cd.slope[1]);
							tile.setCallback(separateSlope);
						}
					}
				}
			}

			Ax.background = AxColor.fromHex(map.backgroundColor);
			Ax.camera.setBounds(0, 0, width, height);

			collider = new AxGroupCollider;
		}

		private function separateSlope(tile:AxTile, entity:AxEntity):void {
			var x:Number = entity.center.x - tile.x;

			var slope:Number = tile.getProperty("slope");
			var intercept:Number = tile.getProperty("intercept");
			
			trace("tile id", tile.index, "has slope", slope, "and intercept", intercept);

			var offset:Number = x;
			var y:Number = AxU.clamp(slope * offset + intercept * tile.height, -Number.MAX_VALUE, tile.height);
			var targetY:Number = tile.y + tile.height - y;

			if (entity.y + entity.height > targetY) {
				entity.y = targetY - entity.height;
				entity.touching |= DOWN;
				entity.velocity.y = 0;
			}
		}
	}
}
