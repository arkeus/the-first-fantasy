package io.arkeus.tff.game {
	import io.arkeus.tff.assets.Resource;
	import io.arkeus.tff.game.world.World;
	import io.arkeus.tff.game.world.WorldBuilder;
	
	import org.axgl.AxState;

	public class GameState extends AxState {
		override public function create():void {
			var builder:WorldBuilder = new WorldBuilder(Resource.WORLD);
			var world:World = builder.build();
			this.add(world);
		}
	}
}
