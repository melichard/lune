/**
 * Created with IntelliJ IDEA.
 * User: Derp
 * Date: 6.7.12
 * Time: 12:30
 * To change this template use File | Settings | File Templates.
 */
package objects {
import flash.geom.Point;
import flash.ui.Keyboard;

import helpers.MathHelp;
import helpers.ObjectProvider;
import helpers.OnFrame;

import starling.display.Image;

import starling.display.Sprite;
import starling.display.Stage;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class Squirrel_HS extends GameObject{
    private var _rotCountLeft:int;
    private var _rotCountRight:int;

    private var velocity:Point;
    private var rot:Number;
    private var prevRot:Number;
    private var vel:Number;

    private var _prevState:Point;

    private var turningLeft:Boolean;
    private var turningRight:Boolean;
    private var autoRotate:Boolean;

    private var _changeCounter:int;

    private var animationPolygon:Vector.<Vector.<Polygon>>;



    public function Squirrel_HS(stage:Stage)
    {
        super(new Point(0,0), "squirell");

        velocity = new Point(3,1);

        x = 480;
        y = 200;

        rot = MathHelp.angle(velocity.x, velocity.y);
        prevRot = MathHelp.angle(velocity.x,  velocity.y);
        vel = MathHelp.prepona(velocity.x,velocity.y);
        _rotCountLeft = 0;
        _rotCountRight = 0;
        _changeCounter = 0;

        _state = new Point(0,21);
        _prevState = new Point(_state.x,  _state.y);

        _initAnimations();

        turningLeft = false;
        turningRight = false;
        autoRotate = false;

        stage.addEventListener(starling.events.TouchEvent.TOUCH, _onTouch);
        stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, _onKeyDown);
        stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, _onKeyUp);
    }

    protected override function _onFrame ():void
    {
        _move();

        _animate();

        if (turningLeft)
            turnLeft();
        if (turningRight)
            turnRight();
    }

    private function _initAnimations():void
    {
        animationPolygon = ObjectProvider.getSquirrelPolygon(this);
    }

    private function _onTouch (e:starling.events.TouchEvent):void{
        var touch:Touch = e.getTouch(stage);

        if (touch && !autoRotate)
        {
            if (touch.globalX < 480 && touch.phase == TouchPhase.BEGAN)
            {
                turningLeft = true;
            } else if (touch.phase == TouchPhase.BEGAN)
            {
                turningRight = true;
            }

            if (touch.globalX < 480 && touch.phase == TouchPhase.ENDED)
            {
                turningLeft = false;
                _rotCountLeft = 0;
            } else if (touch.phase == TouchPhase.ENDED)
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
        if (_state.y > 42)
            _state.y = 42;


        _setPivot(_pivots[_state.x][_state.y]);
        //_polygon = animationPolygon[_state.x][_state.y];

    }

    private function _move():void
    {

        rot += (_state.y - 21)  * Math.PI/100;
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
        /*_rotCountLeft++;
        if (_rotCountLeft > 100)
            _rotCountLeft = 100;
        rot -= (Math.PI/60)//*(Math.round(_rotCountLeft / 20)); */
        _state.y -= 1;
    }

    public function turnRight():void
    {
        /*_rotCountRight++;
        if (_rotCountRight > 100)
            _rotCountRight = 100;
        rot += (Math.PI/60)//*(Math.round(_rotCountRight / 20)); */
        _state.y += 1;

    }

    public function pause():void
    {
        stage.removeEventListener(starling.events.TouchEvent.TOUCH, _onTouch);
        OnFrame.frameS.remove(_onFrame);
    }

    public function resume():void
    {
        stage.addEventListener(starling.events.TouchEvent.TOUCH, _onTouch);
        OnFrame.frameS.add(_onFrame);
    }

    public function hitGround():Boolean
    {
        for each (var polygonPoint:Point in _polygon.points)
        {
            var globalPoint:Point = MathHelp.rotatePoint(new Point(polygonPoint.x + x, polygonPoint.y + y), new Point(x, y), rotation);
            if (globalPoint.y > 600)
                return true;
        }

        return false;
    }

    protected override function _setTexture(name:String):void
    {
        this.removeChild(_texture);
        _texture = new Image(GraphicsLoader.getFrame(name));
        this.addChild(_texture);
    }
}
}
