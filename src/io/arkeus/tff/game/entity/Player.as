package io.arkeus.tff.game.entity {
	import io.arkeus.tff.assets.Resource;
	
	import org.axgl.Ax;
	import org.axgl.input.AxKey;
	import org.axgl.render.AxBlendMode;

	public class Player extends Entity {
		private static const SPEED:uint = 400;
		
		public function Player() {
			super(50, 50, Resource.PLAYER, 72, 100);
			
			addAnimation("stand", [15], 15, false);
			addAnimation("walk", [0, 1, 2, 3, 4, 5, 6, 7], 10);
			animate("walk");
			
			acceleration.y = 1200;
			
			blend = AxBlendMode.TRANSPARENT_TEXTURE;
		}
		
		override public function update():void {
			handleInput();
			handleAnimation();
			super.update();
		}
		
		private function handleInput():void {
			if (Ax.keys.held(AxKey.A)) {
				velocity.x = -SPEED;
			} else if (Ax.keys.held(AxKey.D)) {
				velocity.x = SPEED;
			} else {
				velocity.x = 0;
			}
			
			if (Ax.keys.pressed(AxKey.W) && touching & DOWN) {
				velocity.y = -450;
			}
		}
		
		private function handleAnimation():void {
			if (velocity.x < 0) {
				facing = LEFT;
				animate("walk");
			} else if (velocity.x > 0) {
				facing = RIGHT;
				animate("walk");
			} else {
				animate("stand");
			}
		}
	}
}
