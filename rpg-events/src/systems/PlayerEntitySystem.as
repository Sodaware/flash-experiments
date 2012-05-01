package systems
{
	import components.PlayerComponent;
	import net.sodaware.apollo.ComponentType;
	import net.sodaware.apollo.ComponentTypeManager;
	import net.sodaware.apollo.Entity;
	import net.sodaware.apollo.EntityProcessingSystem;
	import net.sodaware.apollo.util.ImmutableBag;
	
	
	import util.ArrayUtil;
	import org.flixel.FlxG;
	
	public class PlayerEntitySystem extends EntityProcessingSystem
	{
		private var _playerLookup:ComponentType;
		public static var collideTiles:Array = [0, 2, 14, 16, 17]
		
		public const STATE_STANDING:int = 1;
		public const STATE_MOVING:int = 2;
		
		public const DIRECTION_DOWN:int 	= 1;
		public const DIRECTION_LEFT:int 	= 2;
		public const DIRECTION_RIGHT:int 	= 4;
		public const DIRECTION_UP:int 		= 8;
		
		public function PlayerEntitySystem(requiredType:Class, ...otherTypes) 
		{
			super(requiredType, otherTypes);
			
			this._playerLookup = ComponentTypeManager.getTypeFor(requiredType);
		}
		
		override public function processEntities(entities:ImmutableBag):void 
		{
			for (var i:int = 0; i < entities.getSize(); i++) {
				this.processEntity(entities.get(i) as Entity);
			}
		}
		
		override public function processEntity(e:Entity):void 
		{
			// Fetch player component
			var player:PlayerComponent = e.getComponent(this._playerLookup) as PlayerComponent;
			
			// Handle walking
			if (player.state == STATE_STANDING) {
				
				if (FlxG.keys.RIGHT) {
					this._setMove(player, DIRECTION_RIGHT, "walk_right");
				}
				
				if (FlxG.keys.LEFT) {
					this._setMove(player, DIRECTION_LEFT, "walk_left");
				}

				if (FlxG.keys.UP) {
					this._setMove(player, DIRECTION_UP, "walk_up");
				}
				
				if (FlxG.keys.DOWN) {
					this._setMove(player, DIRECTION_DOWN, "walk_down");
				}
				
			}
			
			if (player.state == STATE_MOVING) {
				
				switch (player.direction) {
					
					case DIRECTION_LEFT:
						player.sprite.x -= 2;
						player.moveOffset += 1;
						break;
				
					case DIRECTION_RIGHT:
						player.sprite.x += 2;
						player.moveOffset += 1;
						break;
						
					case DIRECTION_UP:
						player.sprite.y -= 2;
						player.moveOffset += 1;
						break;
				
					case DIRECTION_DOWN:
						player.sprite.y += 2; 
						player.moveOffset += 1;
						break;
						
				}

				// Check if movement is done
				if (player.moveOffset == (24 / 2)) {
					player.moveOffset = 0;
					player.state = STATE_STANDING;
				}
				
			}		

		}
		
		
		protected function _canMove(cmp:PlayerComponent, dir:int) : Boolean
		{
			var tileX:int = cmp.sprite.x / 24;
			var tileY:int = cmp.sprite.y / 24;
			
			switch (dir) {
				
				case DIRECTION_LEFT:
					if (ArrayUtil.inArray(cmp.map.getTile(tileX - 1, cmp.sprite.y / 24), collideTiles) ) {
						return false;
					}
					break;
				
				case DIRECTION_RIGHT:
					if (ArrayUtil.inArray(cmp.map.getTile(tileX + 1, cmp.sprite.y / 24), collideTiles) ) {
						return false;
					}
					break;

				case DIRECTION_UP:
					if (ArrayUtil.inArray(cmp.map.getTile(tileX, tileY - 1), collideTiles) ) {
						return false;
					}
					break;
					
				case DIRECTION_DOWN:
					if (ArrayUtil.inArray(cmp.map.getTile(tileX, tileY + 1), collideTiles) ) {
						return false;
					}
					break;

			}

			
			return true;
		}
		
		
		protected function _setMove(cmp:PlayerComponent, dir:int, anim:String) : void
		{
			if (cmp.direction != dir) {
				cmp.direction = dir;
				cmp.sprite.play(anim);
			}
			
			if (this._canMove(cmp, dir) == false) {
				cmp.state = STATE_STANDING;
				return;
			}

			cmp.state = STATE_MOVING;
			cmp.direction = dir;
			cmp.sprite.play(anim);
		}
		
	}
	
	
}