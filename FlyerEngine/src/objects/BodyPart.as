/**
 * Created with IntelliJ IDEA.
 * User: Derp
 * Date: 11.10.12
 * Time: 10:14
 * To change this template use File | Settings | File Templates.
 */
package objects {
import flash.display.BitmapData;
import flash.display3D.textures.Texture;
import flash.geom.Point;

import helpers.MathHelp;
import helpers.OnFrame;

import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

public class BodyPart extends GameObject{


    private var _velocity:Point;
    private var _speed:Number;

    public var _nextPoint:Vector.<Point>;
    private var _nextVels:Vector.<Point>;

    private var _nextPart:BodyPart;
    private var _popop:Point;
    private var _distance:Number;

    public function BodyPart(position:Point, id:String) {
        super(position,  id)
        _velocity = new Point(3,0);

        x = position.x;
        y = position.y;
        _popop = position;

        _nextPoint = new Vector.<Point>();
        _nextVels = new Vector.<Point>();

        _setTexture(_states[_state.x][_state.y]);
        _setPivot(_pivots[_state.x][_state.y]);

        OnFrame.frameS.add(_onFrame);
    }

    protected override function _onFrame():void
    {
        _move();
    }

    public function _setNextPart(part:BodyPart):void
    {
        _nextPart = part;
        _distance = Point.distance(position,  _nextPart.position);
    }

    public function _removePoints():void
    {
        _nextPoint.length = 0;
        _nextVels.length = 0;
    }

    public function _setVelocity(velocity:Point):void
    {
        _velocity = velocity;
       // _nextPart.addNextPoint(new Point(x, y), _velocity);
    }

    public function _setVelocity2(velocity:Point):void
    {
        _velocity  = velocity;
    }

    public function get velocity():Point
    {
        return _velocity;
    }

    private function _move():void
    {
        rotation = MathHelp.angle(_velocity.x, _velocity.y);
//        if (_nextPoint.length > 0)
//            {
//            if (int(x) == int(_nextPoint[0].x) && int(y) == int(_nextPoint[0].y))
//            {
//                _velocity = _nextVels[0];
//                if (_nextPart)
//                {
//                    _nextPart.addNextPoint(_nextPoint[0],_nextVels[0]);
//                }
//
//                _nextPoint.shift();
//                _nextVels.shift();
//            }
//           }
        if (_nextPart)
        {
            var rot:Number = MathHelp.angle(_nextPart.x - x,  _nextPart.y - y);
            _speed = Point.distance(position,  _nextPart.position) - _distance;
            var newVel:Point = MathHelp.vectorFromRad(rot, _speed);
            _velocity.x = newVel.x;
            _velocity.y = newVel.y;
        }

        x += _velocity.x;
        y += _velocity.y;
    }

    public function addNextPoint(point:Point,  vel:Point):void
    {
        _nextPoint.push(point);
        _nextVels.push(vel);
    }

    public function pause():void
    {
        OnFrame.frameS.remove(_onFrame);
    }

    public function resume():void
    {
        OnFrame.frameS.add(_onFrame);
    }
}
}
