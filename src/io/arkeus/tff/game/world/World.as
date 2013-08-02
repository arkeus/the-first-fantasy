package io.arkeus.tff.game.world {
	import org.axgl.Ax;
	import org.axgl.AxEntity;
	import org.axgl.tilemap.AxTile;
	import org.axgl.tilemap.AxTilemap;

	public class World extends AxTilemap {
		public function World() {
			super();
			Ax.background.hex = 0xffd0f4f7;
		}
		
		public function initialize():void {
			for each (var tile:AxTile in getTiles([1, 2, 3, 5, 6])) {
				tile.collision = UP;
				tile.oneWay = true;
			}
			
			getTile(12).collision = NONE;
			getTile(5).collision = NONE;
			getTile(6).collision = NONE;
			// tile_id: [slope, intercept]
			
			setSlopes({
				4: [1, 0],
				7: [-1, 1]
			});
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
			if (x < 0 || x > tile.width) {
				return;
			}
			var y:Number = tile.getProperty("slope") * x + tile.getProperty("intercept");
			var targetY:Number = tile.y + tile.height - y;
			if (entity.y + entity.height > targetY) {
				entity.y = targetY - entity.height;
				entity.touching |= DOWN;
			}
		}
	}
}
