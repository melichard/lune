package objects
{
import flash.geom.Point;

import helpers.MathHelp;
import helpers.ObjectProvider;
import helpers.OnFrame;
import helpers.ScoreHelper;

import org.osflash.signals.Signal;

import starling.display.Image;
import starling.display.Sprite;
	
	public class GameObject extends starling.display.Sprite
	{
        protected var _id:String;

		protected var _texture:starling.display.Image;
        protected var _polygon:Polygon;

        protected var _state:Point;

        protected var _states:Vector.<Vector.<String>>;
        protected var _pivots:Vector.<Vector.<Point>>;

        protected var _score:int;

        public var isHit:Boolean;
        public var _firstHit:Boolean;

        private var _position:Point;
		
		
		public function GameObject(position:Point, id:String = "xtree01a")
		{
            _id = id;

			_position = new Point();
			if (position)
			{
	            x = position.x;
	            y = position.y;
			}

            _polygon = ObjectProvider.getPolygon(this);
            _states = ObjectProvider.getStates(this);
            _pivots = ObjectProvider.getPivots(this);
            _score = 400;

            isHit = false;
            _firstHit = true;


			OnFrame.frameS.add(_onFrame);

            _state = new Point(0,0);
//            touchable = false;
		}
		
		public function changeType(type:String):void
		{
			_id = type;
			_polygon = ObjectProvider.getPolygon(this);
			_states = ObjectProvider.getStates(this);
			_pivots = ObjectProvider.getPivots(this);			
			
			_setTexture(_states[_state.x][_state.y]);
			_setPivot (_pivots[_state.x][_state.y]);
		}

        public function rotate(center:Point):void
        {
            rotation = MathHelp.angle(center.x - x, center.y - y) - Math.PI;
        }

        public function get polygon():Polygon
        {
            return _polygon;
        }

        public function get position():Point
        {
            _position.x = x;
            _position.y = y;
            return _position;
        }
		
		protected function _onFrame():void
		{
            //_polygon = animationPolygon[state];
		}
		
		public function onHit():void
		{
		}

        protected function _setTexture(name:String):void
        {
			removeChild(_texture);
            _texture = new Image(GraphicsLoader.getFrame(name));

            _texture.pivotX = _texture.width / 2;
            _texture.pivotY = _texture.height / 2;

            this.addChild(_texture);
        }

        public function _setPivot(point:Point):void
        {
            pivotX = point.x;
            pivotY = point.y;
            _texture.x = point.x;
            _texture.y = point.y;
            _texture.pivotX = pivotX;
            _texture.pivotY = pivotY;
        }

        public function get getId():String
        {
            return _id;
        }

        public function get score():int
        {
            return _score;
        }

	}
}