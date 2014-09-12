package io.arkeus.tff.game.entity {
	import io.arkeus.tff.assets.Resource;
	
	import io.axel.Ax;
	import io.axel.input.AxKey;
	import io.axel.render.AxBlendMode;

	public class Player extends Entity {
		private static const WALK_SPEED:uint = 150;
		private static const RUN_SPEED:uint = 250;
		private static const ACCELERATION:uint = 400;
		
		public function Player() {
			super(50, 50, Resource.TILES_V2, 21, 21);
			
			animations.addAtlas("stand", [[462, 2]], 15, false);
			
			animations.add("stand", [15], 15, false);
			animations.add("walk", [0, 1, 2, 3, 4, 5, 6, 7], 10);
			animate("walk");
			
			acceleration.y = 1200;
			drag.x = 600;
			
			width = 26;
			offset.x = 5;
			height = 20;
			offset.y = 29;
			
			blend = AxBlendMode.TRANSPARENT_TEXTURE;
		}
		
		override public function update():void {
			handleInput();
			handleAnimation();
			super.update();
		}
		
		private function handleInput():void {
			if (Ax.keys.held(AxKey.A)) {
				acceleration.x = -ACCELERATION;
			} else if (Ax.keys.held(AxKey.D)) {
				acceleration.x = ACCELERATION;
			} else {
				acceleration.x = 0;
			}
			
			if (acceleration.x > 0 && velocity.x < 0 || acceleration.x < 0 && velocity.x > 0) {
				acceleration.x *= 2;
			}
			
			maxVelocity.x = speed;
			
			if (Ax.keys.pressed(AxKey.W) && touching & DOWN) {
				velocity.y = -450;
			}
		}
		
		private function handleAnimation():void {
			if (acceleration.x < 0) {
				facing = LEFT;
				animate("walk");
			} else if (acceleration.x > 0) {
				facing = RIGHT;
				animate("walk");
			} else {
				animate("stand");
			}
		}
		
		private function get speed():Number {
			return !Ax.keys.held(AxKey.SHIFT) ? RUN_SPEED : WALK_SPEED;
		}
	}
}
