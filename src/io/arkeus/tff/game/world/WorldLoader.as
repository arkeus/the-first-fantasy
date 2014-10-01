package io.arkeus.tff.game.world {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import io.arkeus.tff.assets.Resource;
	import io.arkeus.tiled.TiledReader;
	import io.axel.base.AxEntity;

	public class WorldLoader {
		private var map:Class;
		private var graphic:Class;

		public function WorldLoader(map:Class, graphic:Class) {
			this.map = map;
			this.graphic = graphic;
		}

		public function build():World {
			var collision:Vector.<CollisionDescriptor> = buildCollision();

			var world:World = new World(collision);
			world.load(new TiledReader().loadFromEmbedded(map));
			return world;
		}

		private function buildCollision():Vector.<CollisionDescriptor> {
			var collision:Vector.<CollisionDescriptor> = new Vector.<CollisionDescriptor>;
			var bitmap:BitmapData = (new Resource.COLLISION as Bitmap).bitmapData;
			for (var y:uint = Tile.MARGIN + 2; y < bitmap.height; y += Tile.SIZE + Tile.SPACING) {
				for (var x:uint = Tile.MARGIN + 2; x < bitmap.width; x += Tile.SIZE + Tile.SPACING) {
					var ul:Boolean = ((bitmap.getPixel32(x, y) & 0xff000000) >>> 24) > 0;
					var ur:Boolean = ((bitmap.getPixel32(x + 11, y) & 0xff000000) >>> 24) > 0;
					var dl:Boolean = ((bitmap.getPixel32(x, y + 11) & 0xff000000) >>> 24) > 0;
					var dr:Boolean = ((bitmap.getPixel32(x + 11, y + 11) & 0xff000000) >>> 24) > 0;
					var tx:uint = x / (Tile.SIZE + Tile.SPACING);
					var ty:uint = y / (Tile.SIZE + Tile.SPACING);
					if (ul && ur && dl && dr) {
						collision.push(new CollisionDescriptor(tx, ty, AxEntity.ANY));
					} else if (ul && ur) {
						collision.push(new CollisionDescriptor(tx, ty, AxEntity.UP));
					} else if (ul && dr) {
						collision.push(new CollisionDescriptor(tx, ty, AxEntity.NONE, [-1, 1]));
						trace(tx, ty, "is sloping down");
					} else if (ur && dl) {
						collision.push(new CollisionDescriptor(tx, ty, AxEntity.NONE, [1, 0]));
						trace(tx, ty, "is sloping up");
					}
				}
			}
			return collision;
		}
	}
}
