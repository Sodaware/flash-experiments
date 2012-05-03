package
{
	import org.flixel.*; 
	import screens.PlayState;

	// Set options for Flash file
	[SWF(width = "640", height = "400", backgroundColor = "#000000")]
 	//[Frame(factoryClass = "Preloader")]
	
	public class Main extends FlxGame
	{
		
		public function Main()
		{
			super(320, 200, PlayState, 2);
		}

	}

}