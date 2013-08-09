package io.arkeus.tff.game.world {
	import org.axgl.Ax;
	import org.axgl.AxEntity;
	import org.axgl.AxU;
	import org.axgl.render.AxBlendMode;
	import org.axgl.tilemap.AxTile;
	import org.axgl.tilemap.AxTilemap;

	public class World extends AxTilemap {
		public function World() {
			super();
			Ax.background.hex = 0xffd0f4f7;
			blend = AxBlendMode.TRANSPARENT_TEXTURE;
		}
		
		public function initialize():void {
			for each (var tile:AxTile in getTiles([1, 2, 3, 5, 6])) {
				tile.collision = UP;
				tile.oneWay = true;
			}
			
			getTile(12).collision = NONE;
			getTile(5).collision = NONE;
			getTile(6).collision = NONE;
			getTile(14).collision = getTile(24).collision = NONE;
			// tile_id: [slope, intercept]
			
			setSlopes({
				4: [1, 0],
				7: [-1, 1]
			});
			
			Ax.camera.setBounds(0, 0, width, height);
		}
		
		private function setSlopes(slopeMap:Object):void {
			for (var tileId:uint in slopeMap) {
				var slopeInfo:Array = slopeMap[tileId];
				var tile:AxTile = getTile(tileId);
				tile.setProperty("slope", slopeInfo[0]);
				tile.setProperty("intercept", slopeInfo[1]);
				tile.setCallback(separateSlope);
				tile.collision = NONE;
			}
		}
		
		private function separateSlope(tile:AxTile, entity:AxEntity):void {
			var x:Number = entity.center.x - tile.x;
			
			var slope:Number = tile.getProperty("slope");
			var intercept:Number = tile.getProperty("intercept");
			
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
