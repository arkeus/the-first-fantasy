package io.arkeus.tff.game {
	import io.arkeus.tff.assets.Resource;
	import io.arkeus.tff.game.entity.Player;
	import io.arkeus.tff.game.world.World;
	import io.arkeus.tff.game.world.WorldBuilder;
	
	import org.axgl.Ax;
	import org.axgl.AxState;

	public class GameState extends AxState {
		public var world:World;
		public var player:Player;
		
		override public function create():void {
			var builder:WorldBuilder = new WorldBuilder(Resource.WORLD);
			this.add(world = builder.build());
			this.add(player = new Player);
			
			Ax.camera.follow(player);
		}
		
		override public function update():void {
			super.update();
			
			Ax.collide(player, world);
		}
	}
}
