package io.arkeus.tff.assets {
	public class Resource {
		[Embed(source = "/world/world.png")] public static const WORLD:Class;
		[Embed(source = "/world/tiles.png")] public static const TILES:Class;
		
		[Embed(source = "/entity/player.png")] public static const PLAYER:Class;
		[Embed(source = "/entity/player_small.png")] public static const PLAYER_SMALL:Class;
	}
}
