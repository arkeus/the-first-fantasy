package io.arkeus.tff.game.world {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import io.arkeus.tff.assets.Resource;
	
	import org.axgl.AxU;

	public class WorldBuilder {
		private var pixels:BitmapData;
		private var x:uint, y:uint;
		private var lp:uint, rp:uint, up:uint, dp:uint, cp:uint;
		private var l:Boolean, r:Boolean, u:Boolean, d:Boolean, c:Boolean;
		private var ulp:uint, urp:uint, dlp:uint, drp:uint;
		private var ul:Boolean, ur:Boolean, dl:Boolean, dr:Boolean;
		
		public function WorldBuilder(pixels:Class) {
			this.pixels = (new pixels as Bitmap).bitmapData;
		}
		
		public function build():World {
			var world:World = new World;
			var data:Array = [];
			
			for (y = 0; y < pixels.height; y++) {
				var row:Array = []
				for (x = 0; x < pixels.width; x++) {
					pixelSetup();
					row.push(getTile());
				}
				data.push(row);
			}
			
			world.build(data, Resource.TILES, Tile.SIZE, Tile.SIZE, 1);
			world.initialize();
			return world;
		}
		
		private function getTile():uint {
			if (!c) {
				return 0;
			}
			
			if (l && r && u && d) {
				if (!ul) {
					return 5;
				} else if (!ur) {
					return 6;
				}
				return 12;
			} else if (l && d && r) {
				return 2;
			} else if (u && r && d) {
				return 11;
			} else if (u && l && d) {
				return 13;
			} else if (l && u && r) {
				return 22;
			} else if (u && r) {
				return 21;
			} else if (u && l) {
				return 23;
			} else if (r && d) {
				if (dl || ur) {
					return 4;
				}
				return 1;
			} else if (l && d) {
				if (dr || ul) { 
					return 7;
				}
				return 3;
			}
			
			return 0;
		}
		
		private function pixelSetup():void {
			cp = pixels.getPixel(x, y);
			lp = pixels.getPixel(x - 1, y);
			rp = pixels.getPixel(x + 1, y);
			up = pixels.getPixel(x, y - 1);
			dp = pixels.getPixel(x, y + 1);
			ulp = pixels.getPixel(x - 1, y - 1);
			urp = pixels.getPixel(x + 1, y - 1);
			dlp = pixels.getPixel(x - 1, y + 1);
			drp = pixels.getPixel(x + 1, y + 1);
			
			c = cp != 0x0 && cp != 0xffffff;
			l = cp == lp || x == 0;
			r = cp == rp || x == pixels.width - 1;
			d = cp == dp || y == pixels.height - 1;
			u = cp == up || y == 0;
			ul = cp == ulp || x == 0 || y == 0;
			ur = cp == urp || x == pixels.width - 1 || y == 0;
			dl = cp == dlp || x == 0 || y == pixels.height - 1;
			dr = cp == drp || x == pixels.width - 1 || y == pixels.height - 1;
		}
	}
}
