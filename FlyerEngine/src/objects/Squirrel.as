package objects
{
import flash.display.Sprite;
import flash.geom.Point;
import flash.ui.Keyboard;

import helpers.MathHelp;
import helpers.ObjectProvider;
import helpers.OnFrame;

import starling.display.Image;

import starling.display.Stage;
import starling.events.Event;
import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Squirrel extends starling.display.Sprite
	{
        private var _parts:Vector.<BodyPart>;

        public var _turningLeft:Boolean;
        public var _turningRight:Boolean;
        private var _controlSwitch:Boolean;

        private var rot:Number;
        private var _speed:Number;



        public function Squirrel()
        {
            super();

            _turningLeft = false;
            _turningRight = false;
            _controlSwitch = false;
            this.addEventListener(Event.ADDED_TO_STAGE,  _onAdded);
            _speed = 3;

        }

        private function _onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, _onAdded);

            _initParts();

            stage.addEventListener(starling.events.TouchEvent.TOUCH, _onTouch);

            OnFrame.frameS.add(_onFrame);
        }

        private function _initParts():void
        {
            _parts = new Vector.<BodyPart>();

            for (var i:int = 0; i < 9; i++)
            {
                var position:Point = new Point(0,stage.stageHeight - 140);
                switch (i)
                {
                    case 0: position.x = stage.stageWidth/2; break;
                    case 1: position.x = stage.stageWidth/2 - 12; break;
                    case 2: position.x = stage.stageWidth/2 - 24; break;
                    case 3: position.x = stage.stageWidth/2 - 42; break;
                    case 4: position.x = stage.stageWidth/2 - 48; break;
                    case 5: position.x = stage.stageWidth/2 - 66; break;
                    case 6: position.x = stage.stageWidth/2 - 78; break;
                    case 7: position.x = stage.stageWidth/2 - 84; break;
                    case 8: position.x = stage.stageWidth/2 - 96; break;
                }

                _parts.push(new BodyPart(position, "v0" + (i + 1)));
            }

            for (i = 1; i < 9; i++)
            {
                _parts[i]._setNextPart(_parts[i-1]);
            }

            addChild(_parts[1]);
            addChild(_parts[2]);
            addChild(_parts[0]);
            addChild(_parts[8]);
            addChild(_parts[7]);
            addChild(_parts[6]);
            addChild(_parts[5]);
            addChild(_parts[4]);
            addChild(_parts[3]);

            rot = MathHelp.angle(_parts[0].velocity.x, _parts[0].velocity.y);

        }

        public function _onFrame():void
        {
            if (_turningLeft)
                _turnLeft();
            else if (_turningRight)
                _turnRight();
            if (_turningLeft || _turningRight)
            {
                var vel:Number = MathHelp.prepona(_parts[0].velocity.x, _parts[0].velocity.y);
                var newVel:Point = MathHelp.vectorFromRad(rot,vel);
                _parts[0]._setVelocity2(newVel);
            }
        }

        public function setSpeed(vel:Number):void
        {
            var newVel:Point = MathHelp.vectorFromRad(rot,vel);
            _parts[0]._setVelocity(newVel);
            _speed = vel;

        }

        private function _onTouch (e:starling.events.TouchEvent):void{
            var touches:Vector.<Touch> = e.getTouches(stage);

            for each (var touch:Touch in touches)
            {
                if (touch)
                {
                    if (touch.globalX <= stage.stageWidth/2 && touch.phase == TouchPhase.BEGAN)
                    {
                        _turningLeft = true;
                    }
                    if (touch.globalX >= stage.stageWidth/2 && touch.phase == TouchPhase.BEGAN)
                    {
                        _turningRight = true;
                    }

                    if (touch.globalX < stage.stageWidth/2 && touch.phase == TouchPhase.ENDED)
                    {
                        _turningLeft = false;
                    }
                    if (touch.globalX > stage.stageWidth/2 && touch.phase == TouchPhase.ENDED)
                    {
                        _turningRight = false;
                    }
                }
            }
        }


        private function _turnLeft():void
        {
            if (_controlSwitch)
                rot += Math.PI/60
            else
                rot -= Math.PI/60;
        }

        private function _turnRight():void
        {
            if (_controlSwitch)
                rot -= Math.PI/60
            else
                rot += Math.PI/60;
        }

        public function get position():Point
        {
            return new Point(_parts[0].x,  _parts[0].y);
        }

        public function get velx():Number
        {
            return _parts[0].velocity.x;
        }

        public function set turningLeft(val:Boolean):void
        {
            _turningLeft = val;
        }

        public function set turningRight(val:Boolean):void
        {
            _turningRight = val;
        }

        public function pause():void
        {
//            stage.removeEventListener(starling.events.TouchEvent.TOUCH, _onTouch);
            OnFrame.frameS.remove(_onFrame);
            for (var i:int = 0; i < 9; i++)
            {
                parts[i].pause();
            }
        }

        public function resume():void
        {
            stage.addEventListener(starling.events.TouchEvent.TOUCH, _onTouch);
            OnFrame.frameS.add(_onFrame);

            for (var i:int = 0; i < 9; i++)
            {
                parts[i].pause();
            }
        }

        public function switchControls():void
        {
           if (_controlSwitch)
            _controlSwitch = false;
           else
            _controlSwitch = true;
        }

        public function collides(polygon:Polygon):Boolean
        {
            for (var i:int = 0; i < 9; i++)
            {
                if (_parts[i].polygon.collides(polygon))
                    return true;
            }
            return false;
        }

        public function get parts():Vector.<BodyPart>
        {
           return _parts;
        }

        public function get speed():Number
        {
            return _speed;
        }

        /*private var _rotCountLeft:int;
        private var _rotCountRight:int;

        private var velocity:Point;
        private var rot:Number;
        private var prevRot:Number;
        private var vel:Number;
        private var dif:Number;

        private var _prevState:Point;

		private var turningLeft:Boolean;
		private var turningRight:Boolean;

        private var _changeCounter:int;

        private var animationPolygon:Vector.<Vector.<Polygon>>;
		
		public function Squirrel(stage:Stage)
		{
            super(new Point(0,0), "squirrel");

			velocity = new Point(2,1);

			x = 480;
			y = 200;

			rot = MathHelp.angle(velocity.x, velocity.y);
            prevRot = MathHelp.angle(velocity.x,  velocity.y);
			vel = MathHelp.prepona(velocity.x,velocity.y);
            _rotCountLeft = 0;
            _rotCountRight = 0;
            _changeCounter = 0;

            _state = new Point(0,19);
            _prevState = new Point(_state.x,  _state.y);
            dif = 0;

            _initAnimations();

			turningLeft = false;
			turningRight = false;

            stage.addEventListener(starling.events.TouchEvent.TOUCH, _onTouch);
            stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, _onKeyDown);
            stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, _onKeyUp)
		}
		
		protected override function _onFrame ():void
        {
           	_move();

            _animate();

			if (turningLeft)
				turnLeft();
			else if (turningRight)
				turnRight();
            else if (_state.y != 19)
            {
                _state.y += (19 - _state.y)/Math.abs(19 - _state.y);
            }

            dif = prevRot - rot;
            prevRot = rot;
        }

        private function _initAnimations():void
        {
            animationPolygon = ObjectProvider.getSquirrelPolygon(this);
        }
		
		private function _onTouch (e:starling.events.TouchEvent):void{
			var touch:Touch = e.getTouch(stage);

			if (touch)
			{
				if (touch.globalX < 480 && touch.phase == TouchPhase.BEGAN)
				{
					turningLeft = true;					
				}
                if (touch.globalX > 480 && touch.phase == TouchPhase.BEGAN)
				{
					turningRight = true;
				}

				if (touch.globalX < 480 && touch.phase == TouchPhase.ENDED)
				{
					turningLeft = false;
                    _rotCountLeft = 0;
                }
                if (touch.globalX > 480 && touch.phase == TouchPhase.ENDED)
				{
					turningRight = false;
                    _rotCountRight = 0;
				}

			}
			
		}

        private function _onKeyDown (e:starling.events.KeyboardEvent):void{

                if (e.keyCode == Keyboard.LEFT)
                {
                    turningLeft = true;
                } else if (e.keyCode == Keyboard.RIGHT)
                {
                    turningRight = true;
                }

        }


        private function _onKeyUp (e:starling.events.KeyboardEvent):void{
            if (e.keyCode == Keyboard.LEFT)
            {
                turningLeft = false;
                _rotCountLeft = 0;
            } else if (e.keyCode == Keyboard.RIGHT)
            {
                turningRight = false;
                _rotCountRight = 0;
            }
        }

        private function _animate():void
        {
            if (_state.y < 0)
                _state.y = 0;
            if (_state.y > 38)
                _state.y = 38;

            _setTexture(_states[_state.x][_state.y]);

            setPivot(_pivots[_state.x][_state.y]);
            //_polygon = animationPolygon[_state.x][_state.y];

        }

        private function _move():void
        {
            rot += (_state.y - 19)  * Math.PI/500;
            velocity = MathHelp.vectorFromRad(rot, vel);

            if (y < 600 && y >= 200)
            {
                velocity.y += 0.008;//(0.00012*y*Math.abs(Math.cos(rot))) + 0.005;
            } else if (y < 200 && y >= 100)
            {
                velocity.y += 1/y;
            }
            else if (y < 100)
            {
                velocity.y += 2/y;
            }

            rot = MathHelp.angle(velocity.x, velocity.y);
            if (y == 600)
                rot -=  (rot - (Math.abs(rot)/rot)*Math.PI/2)/30;

            rotation = rot;
            vel = MathHelp.prepona(velocity.x,velocity.y);
            y += velocity.y;

        }
		
		public function get velx():Number
		{
			return velocity.x;
		}
		
		public function turnLeft():void
		{
                _rotCountLeft++;
                if (_rotCountLeft % 3== 0)
                    _state.y -= 1;
            }
		
		public function turnRight():void
		{
                _rotCountRight++;
                if (_rotCountRight % 3 == 0)
                    _state.y += 1;
		}



        public function hitGround():Boolean
        {
            for each (var polygonPoint:Point in _polygon.points)
            {
                var globalPoint:Point = MathHelp.rotatePoint(new Point(polygonPoint.x + x, polygonPoint.y + y), new Point(x, y), rotation);
                if (globalPoint.y > 520)
                    return true;
            }

            return false;
        }

        protected override function _setTexture(name:String):void
        {
            this.removeChild(_texture);
            _texture = new Image(GraphicsLoader.getFrame(name));
            this.addChild(_texture);
        }              */
    }
}