/**
 * Created with IntelliJ IDEA.
 * User: Admin
 * Date: 9.11.2012
 * Time: 15:33
 * To change this template use File | Settings | File Templates.
 */
package gui.counter {
import gui.GuiComponent;

import starling.animation.Tween;
import starling.core.Starling;

import starling.text.TextField;
import starling.utils.Color;
import starling.utils.HAlign;

public class GuiCounter extends GuiComponent {

    private var _timeText:TextField;
    private var _timeTextShadow:TextField;
    private var t:Tween;
    private var _time:int;

    public function GuiCounter() {

        TextField.registerBitmapFont(GraphicsLoader.luneFont);

        _timeText = new TextField(100,50,"100","lunetypex", 40, Color.WHITE);
        _timeText.x = -50;
        _timeText.y = -20;
        _timeTextShadow = new TextField(100,50,"100","lunetypex", 40);
        _timeTextShadow.x = -48;
        _timeTextShadow.y = -18;

        _timeText.hAlign = HAlign.CENTER;
        _timeTextShadow.hAlign = HAlign.CENTER;

        addChild(_timeTextShadow);
        addChild(_timeText);

        this.x = 700;
    }

    public function set _startTime(time:int):void
    {
        _timeText.text = "" + int(_time/60);
        _timeTextShadow.text = "" + int(_time/60);
        _time = time;
    }


    public function _set(time:int):void
    {
        if ( int(_time/60) !=  int(time/60) )
        {

        t = new Tween(this, 0.1);
        t.scaleTo(0.9);
        _time = time;

        t.onComplete = changeValueAnimation;

        Starling.juggler.add(t);

        }

    }

    private function changeValueAnimation():void {
        _timeText.text = "" + int(_time/60);
        _timeTextShadow.text = "" + int(_time/60);
        t.reset(this, 0.1);
        t.scaleTo(1);
        Starling.juggler.add(t);
    }
}
}
