package io.arkeus.tff.game.entity.enemy {
	import io.arkeus.tff.assets.Resource;
	import io.arkeus.tff.game.world.Tile;

	public class Slime extends Enemy {
		public function Slime(x:uint, y:uint, initialFrame:uint) {
			super(x, y, Resource.TILES_V2, Tile.SIZE, Tile.SIZE);
			
			animations.addAtlas("walk", [initialFrame], 15, true);
		}
	}
}
