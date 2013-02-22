/**
 * Created with IntelliJ IDEA.
 * User: Tomas
 * Date: 18.1.2013
 * Time: 2:45
 * To change this template use File | Settings | File Templates.
 */
package effects {
import flash.geom.Point;

import helpers.OnFrame;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;
import starling.display.Sprite;

import starling.textures.Texture;

public class EffectMenuNebula extends Sprite {
    private var img1:Image;
    private var img2:Image;
    private var _to:Point;
    private var _time:int;
    private var _currenttime:int;
    private var _from:Point;
    private var t:Tween;
    private var t2:Tween;

    public function EffectMenuNebula(t:Texture) {
        img1 = new Image(t);
        img2 = new Image(t);
        img1.pivotX = img1.width/2;
        img1.pivotY = img1.height/2;
        img2.pivotX = img2.width/2;
        img2.pivotY = img2.height/2;
        addChild(img1);
        addChild(img2);
    }

    public function _animate(from:Point, to:Point, time:int, delay:int=0):void
    {
        img2.x = from.x;
        img2.y = from.y;
        img2.alpha = 0;

        img1.alpha = 1;
        img1.x = (from.x + to.x) / 2;
        img1.y = (from.y + to.y) / 2;


        _from = from;
        _to =  to;
        _time = time;
        _currenttime = delay;

//        OnFrame.frameS.add(update);


        t = new Tween(img1, 10);
        t.moveTo(_to.x, _to.y);
        t.fadeTo(0)
        t.onComplete = repeat;
        Starling.juggler.add(t);

        t2 = new Tween(img2, 10);
        t2.moveTo((from.x + to.x) / 2, (from.y + to.y) / 2);
        t2.fadeTo(1)
        Starling.juggler.add(t2);

    }

    private function repeat():void {

        img2.x = _from.x;
        img2.y = _from.y;
        img2.alpha = 0;

        img1.alpha = 1;
        img1.x = (_from.x + _to.x) / 2;
        img1.y = (_from.y + _to.y) / 2;


//        OnFrame.frameS.add(update);

        Starling.juggler.remove(t);
        Starling.juggler.remove(t2);

        t.reset(img1, 10);
        t.moveTo(_to.x, _to.y);
        t.fadeTo(0)
        t.onComplete = repeat;
        Starling.juggler.add(t);

        t2.reset(img2, 10);
        t2.moveTo((_from.x + _to.x) / 2, (_from.y + _to.y) / 2);
        t2.fadeTo(1)
        Starling.juggler.add(t2);

    }

    private function update():void {


    }
}
}
