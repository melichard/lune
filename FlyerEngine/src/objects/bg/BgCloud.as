package objects.bg {

import gui.notify.GuiScoreNotify;

import helpers.OnFrame;
import helpers.ScoreHelper;
import helpers.SoundHelper;

import objects.*;

import flash.geom.Point;
import org.osflash.signals.Signal;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;

public class BgCloud extends GameObject
{


    public function BgCloud(Position:Point, id:String = "nutt0")
    {
        super(Position, id);

        _setTexture(_states[_state.x][_state.y]);
        _setPivot (_pivots[_state.x][_state.y]);

    }

    public override function onHit():void
    {
    }

}
}
