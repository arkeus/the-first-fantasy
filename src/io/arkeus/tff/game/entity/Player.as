package io.arkeus.tff.game.entity {
	import io.arkeus.tff.assets.Resource;
	
	import io.axel.Ax;
	import io.axel.input.AxKey;
	import io.axel.render.AxBlendMode;

	public class Player extends Entity {
		private static const WALK_SPEED:uint = 80;
		private static const RUN_SPEED:uint = 120;
		private static const ACCELERATION:uint = 300;
		
		public function Player() {
			super(21, 21, Resource.TILES_V2, 21, 21);
			
			animations.addAtlas("stand", [[462, 2]], 15, false);
			animations.addAtlas("walk", [[646, 2], [669, 2]], 8);
			animations.addAtlas("jump", [[600, 2]], 15, false);
			animations.addAtlas("fall", [[623, 2]], 15, false);
			animate("walk");
			
			width = 11;
			offset.x = 5;
			height = 19;
			offset.y = 2;
			
			acceleration.y = 1200;
			drag.x = 600;
			
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
				velocity.y = -350;
			}
		}
		
		private function handleAnimation():void {
			if (velocity.y < 0) {
				animate("jump");
			} else if (velocity.y > 0) {
				animate("fall");
			} else {
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
		}
		
		private function get speed():Number {
			return !Ax.keys.held(AxKey.SHIFT) ? RUN_SPEED : WALK_SPEED;
		}
	}
}
