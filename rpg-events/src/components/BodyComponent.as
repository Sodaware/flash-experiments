package components
{

    import net.sodaware.apollo.Component;
    import org.flixel.FlxSprite;
    import org.flixel.FlxTilemap;
    
    public class BodyComponent extends Component
    {

        // Possible states
        public static const STATE_STANDING:int = 1;
        public static const STATE_MOVING:int = 2;
        
        // Walk directions (again, any actor could have these)
        public static const DIRECTION_DOWN:int 	= 1;
        public static const DIRECTION_LEFT:int 	= 2;
        public static const DIRECTION_RIGHT:int 	= 4;
        public static const DIRECTION_UP:int 		= 8;
        
        private var _sprite:FlxSprite;
        private var _state:int;
        private var _direction:int;
        private var _moveOffset:int;
        private var _map:FlxTilemap;
        
        /**
         * Create a new body component.
         *
         * @param graphic The sprite for this body.
         * @param width Width of animation frame in pixels
         * @param height Height of animation frame in pixels.
         */
        public function BodyComponent(graphic:Class, width:int, height:int)
        {
            this._sprite = new FlxSprite(0, 0);
            this._sprite.loadGraphic(graphic, true, false, width, height);
            
            this._sprite.addAnimation("stand_up", [0, 1], 2);
            this._sprite.addAnimation("stand_right", [2, 3], 2);
            this._sprite.addAnimation("stand_left", [4, 5], 2);
            this._sprite.addAnimation("stand_down", [6, 7], 2);
            
            this._sprite.addAnimation("walk_up", [0, 1], 4);
            this._sprite.addAnimation("walk_right", [2, 3], 4);
            this._sprite.addAnimation("walk_left", [4, 5], 4);
            this._sprite.addAnimation("walk_down", [6, 7], 4);
            
            this._sprite.play("stand_down");
            this.state = 1;
        }
        
        public function getSprite() : FlxSprite
        {
            return this._sprite;
        }
        
        public function get sprite():FlxSprite 
        {
            return _sprite;
        }
        
        public function set sprite(value:FlxSprite):void 
        {
            _sprite = value;
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