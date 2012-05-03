package systems
{
    import components.PlayerComponent;
    import components.BodyComponent;
    import net.sodaware.apollo.ComponentType;
    import net.sodaware.apollo.ComponentTypeManager;
    import net.sodaware.apollo.Entity;
    import net.sodaware.apollo.EntityProcessingSystem;
    import net.sodaware.apollo.util.ImmutableBag;
    
    import util.ArrayUtil;
    import org.flixel.FlxG;
    
    /**
     * Manages the player entity.
     */
    public class PlayerEntitySystem extends EntityProcessingSystem
    {
        // Component lookups
        private var _playerLookup:ComponentType;
        private var _bodyLookup:ComponentType;
        
        // List of collidable tiles - this should be moved to a tileset definition
        public static var collideTiles:Array = [0, 2, 14, 16, 17];
        
        public function PlayerEntitySystem() 
        {
            super(PlayerComponent, BodyComponent);
            
            this._playerLookup = ComponentTypeManager.getTypeFor(PlayerComponent);
            this._bodyLookup = ComponentTypeManager.getTypeFor(BodyComponent);
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
            var body:BodyComponent     = e.getComponent(this._bodyLookup) as BodyComponent;
            
            // Handle input
            this._handleInput(body);
            
            // TODO: This can go further up the chain to an Actor Component
            if (body.state == BodyComponent.STATE_MOVING) {
                
                switch (body.direction) {
                    
                case BodyComponent.DIRECTION_LEFT:
                    body.sprite.x -= 2;
                    body.moveOffset += 1;
                    break;
                    
                case BodyComponent.DIRECTION_RIGHT:
                    body.sprite.x += 2;
                    body.moveOffset += 1;
                    break;
                    
                case BodyComponent.DIRECTION_UP:
                    body.sprite.y -= 2;
                    body.moveOffset += 1;
                    break;
                    
                case BodyComponent.DIRECTION_DOWN:
                    body.sprite.y += 2; 
                    body.moveOffset += 1;
                    break;
                    
                }
                
                // Check if movement is done
                if (body.moveOffset == (24 / 2)) {
                    body.moveOffset = 0;
                    body.state = BodyComponent.STATE_STANDING;
                }
                
            }		
            
        }
        
        protected function _handleInput(body:BodyComponent) : void
        {
            if (body.state == BodyComponent.STATE_STANDING) {
                
                if (FlxG.keys.RIGHT) {
                    this._setMove(body, BodyComponent.DIRECTION_RIGHT, "walk_right");
                }
                
                if (FlxG.keys.LEFT) {
                    this._setMove(body, BodyComponent.DIRECTION_LEFT, "walk_left");
                }
                
                if (FlxG.keys.UP) {
                    this._setMove(body, BodyComponent.DIRECTION_UP, "walk_up");
                }
                
                if (FlxG.keys.DOWN) {
                    this._setMove(body, BodyComponent.DIRECTION_DOWN, "walk_down");
                }
                
            }
        }
        
        protected function _canMove(cmp:BodyComponent, dir:int) : Boolean
        {
            var tileX:int = cmp.sprite.x / 24;
            var tileY:int = cmp.sprite.y / 24;
            
            switch (dir) {
                
				case BodyComponent.DIRECTION_LEFT:
                if (ArrayUtil.inArray(cmp.map.getTile(tileX - 1, cmp.sprite.y / 24), collideTiles) ) {
                    return false;
                }
                break;
                
				case BodyComponent.DIRECTION_RIGHT:
                if (ArrayUtil.inArray(cmp.map.getTile(tileX + 1, cmp.sprite.y / 24), collideTiles) ) {
                    return false;
                }
                break;
                
				case BodyComponent.DIRECTION_UP:
                if (ArrayUtil.inArray(cmp.map.getTile(tileX, tileY - 1), collideTiles) ) {
						return false;
                }
                break;
                
				case BodyComponent.DIRECTION_DOWN:
                if (ArrayUtil.inArray(cmp.map.getTile(tileX, tileY + 1), collideTiles) ) {
                    return false;
                }
                break;
                
            }
            
            
            return true;
        }
        
        
        /**
         * Helper function for setting movement / animation. Could this be moved to the actual component?
         */
        protected function _setMove(body:BodyComponent, dir:int, anim:String) : void
        {
            if (body.direction != dir) {
                body.direction = dir;
                body.sprite.play(anim);
            }
            
            if (this._canMove(body, dir) == false) {
                body.state = BodyComponent.STATE_STANDING;
                return;
            }
            
            body.state = BodyComponent.STATE_MOVING;
            body.direction = dir;
            body.sprite.play(anim);
        }
        
    }

}