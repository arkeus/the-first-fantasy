package io.arkeus.tff.game {
	import io.arkeus.tff.assets.Map;
	import io.arkeus.tff.game.entity.Player;
	import io.arkeus.tff.game.worldv2.WorldV2;
	import io.arkeus.tff.game.worldv2.WorldV2Loader;
	import io.axel.Ax;
	import io.axel.state.AxState;

	public class GameState extends AxState {
		public var world:WorldV2;
		public var player:Player;
		
		override public function create():void {
			var loader:WorldV2Loader = new WorldV2Loader(Map.WORLD);
			this.add(world = loader.build());
			this.add(player = new Player);
			
			Ax.camera.follow(player);
		}
		
		override public function update():void {
			super.update();
			
			Ax.collide(player, world);
		}
	}
}
