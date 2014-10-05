package io.arkeus.tff.game.entity.enemy {
	import io.arkeus.tff.game.entity.Entity;

	public class Enemy extends Entity {
		public function Enemy(x:Number = 0, y:Number = 0, graphic:Class = null, frameWidth:uint = 0, frameHeight:uint = 0) {
			super(x, y, graphic, frameWidth, frameHeight);
		}
	}
}
