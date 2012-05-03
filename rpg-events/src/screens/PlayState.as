package screens 
{
	import components.*;
	import net.sodaware.apollo.ComponentTypeManager;
	import net.sodaware.apollo.Entity;
	import net.sodaware.apollo.World;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import systems.PlayerEntitySystem;
	
    public class PlayState extends FlxState 
    {
        
        // Resources
        [Embed(source = "../../content/layer-0.txt", mimeType = "application/octet-stream")] public static var map_Layer0:Class;
        [Embed(source = "../../content/layer-1.txt", mimeType = "application/octet-stream")] public static var map_Layer1:Class;
        [Embed(source = "../../content/overworld.png")] public static var gfx_Tiles:Class;
        
        // Drawable Things
        private var _layer0:FlxTilemap;
        private var _layer1:FlxTilemap;
        
        // Apollo
        private var _world:World;
        
        override public function update() : void 
        {
            this._world.execute();
            this._world.getSystemManager().processAll();
            super.update();
        }
        
        override public function create():void 
        {
            // Create world
            this._world = new World();
            
            // Add systems
            this._world.getSystemManager().addSystem(new PlayerEntitySystem());
            
            // Create player
            var player:Entity = this._world.createEntity();
            var cmp:PlayerComponent = new PlayerComponent;
            var body:BodyComponent = new BodyComponent(PlayerComponent.gfx_Player, 24, 24); 
            player.addComponent(cmp);

            player.addComponent(body);
            
            // TODO: This is super ugly. Make it pretty (we need access to sprite for following / rendering)
            var playerSprite:FlxSprite = body.sprite;
            
            this._layer0 = new FlxTilemap();
            this._layer0.loadMap(new map_Layer0, gfx_Tiles, 24, 24);
            
            this._layer1 = new FlxTilemap();
            this._layer1.loadMap(new map_Layer1, gfx_Tiles, 24, 24);
            
            body.map = this._layer0;
            
            this.add(this._layer0);
            this.add(playerSprite);
            this.add(this._layer1);
            
            
            
            FlxG.camera.setBounds(0, 0, this._layer0.width, this._layer0.height);
            FlxG.camera.follow(playerSprite);
            
        }
        
    }

}