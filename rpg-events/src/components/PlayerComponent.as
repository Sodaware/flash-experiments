package components
{
	import net.sodaware.apollo.Component;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import systems.PlayerEntitySystem;
	
	public class PlayerComponent extends Component
	{
		[Embed(source = "../../content/char_cody.png")] public static var gfx_Player:Class;

		
		// Objects
		private var _player:FlxSprite;
		private var _state:int;
		private var _direction:int;
		private var _moveOffset:int;
		private var _map:FlxTilemap;
		
		
		public function PlayerComponent()
		{
			this._player = new FlxSprite(24, 24);
			this._player.loadGraphic(gfx_Player, true, false, 24, 24);
			
			this._player.addAnimation("stand_up", [0, 1], 2);
			this._player.addAnimation("stand_right", [2, 3], 2);
			this._player.addAnimation("stand_left", [4, 5], 2);
			this._player.addAnimation("stand_down", [6, 7], 2);
			
			this._player.addAnimation("walk_up", [0, 1], 4);
			this._player.addAnimation("walk_right", [2, 3], 4);
			this._player.addAnimation("walk_left", [4, 5], 4);
			this._player.addAnimation("walk_down", [6, 7], 4);

			this._player.play("stand_down");
			this.state = 1;
		}
		
		public function getSprite() : FlxSprite
		{
			return this._player;
		}
		
		public function get sprite():FlxSprite 
		{
			return _player;
		}
		
		public function set sprite(value:FlxSprite):void 
		{
			_player = value;
		}
		
		public function get state():int 
		{
			return _state;
		}
		
		public function set state(value:int):void 
		{
			_state = value;
		}
		
		public function get direction():int 
		{
			return _direction;
		}
		
		public function set direction(value:int):void 
		{
			_direction = value;
		}
		
		public function get moveOffset():int 
		{
			return _moveOffset;
		}
		
		public function set moveOffset(value:int):void 
		{
			_moveOffset = value;
		}
		
		public function get map():FlxTilemap 
		{
			return _map;
		}
		
		public function set map(value:FlxTilemap):void 
		{
			_map = value;
		}
	}
	
}