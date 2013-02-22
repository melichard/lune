package objects.enemies {
import flash.geom.Point;

import helpers.MathHelp;

import objects.GameObject;

import org.osflash.signals.Signal;

public class Projectile extends GameObject
{
    private var _target:Point;

    private var _vel:Number;
    private var _velocity:Point;

    public function Projectile(position:Point, target:Point) {
        super(position);

        _vel = 10;

        this._target = target;

        rotation = MathHelp.angle(target.x - position.x,  target.y - position.y);

        _velocity = MathHelp.vectorFromRad(rotation,  _vel);

    }

    protected override function _onFrame():void
    {
        x += _velocity.x;
        y += _velocity.y;
    }

    public override function onHit():void
    {
    }

}
}
