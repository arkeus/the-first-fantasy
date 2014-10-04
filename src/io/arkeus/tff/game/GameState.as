package io.arkeus.tff.game {
	import io.arkeus.tff.assets.Map;
	import io.arkeus.tff.assets.Resource;
	import io.arkeus.tff.game.entity.Player;
	import io.arkeus.tff.game.world.World;
	import io.arkeus.tff.game.world.WorldLoader;
	import io.axel.Ax;
	import io.axel.state.AxState;

	public class GameState extends AxState {
		public var world:World;
		public var player:Player;
		
		override public function create():void {
			var loader:WorldLoader = new WorldLoader(Map.WORLD, Resource.TILES_V2);
			this.add(world = loader.build());
			this.add(player = new Player);
			
			Ax.camera.follow(player);
		}
		
		override public function update():void {
			super.update();
			
			Ax.collide(player, world, null, world.collider);
		}
	}
}
