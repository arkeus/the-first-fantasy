package io.arkeus.tff.game.world {
	public class CollisionDescriptor {
		public var x:uint;
		public var y:int;
		public var collision:uint;
		public var slope:Array;
		
		public function CollisionDescriptor(x:uint, y:uint, collision:uint, slope:Array = null) {
			this.x = x;
			this.y = y;
			this.collision = collision;
			this.slope = slope;
		}
	}
}
