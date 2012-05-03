package components
{
    import net.sodaware.apollo.Component;
    import org.flixel.FlxSprite;
    import org.flixel.FlxTilemap;
    import systems.PlayerEntitySystem;
    
    public class PlayerComponent extends Component
    {
        [Embed(source = "../../content/char_cody.png")] public static var gfx_Player:Class;
        
        public function PlayerComponent()
        {
        
        }
        
    }
	
}