/**
 * Created with IntelliJ IDEA.
 * User: Admin
 * Date: 9.11.2012
 * Time: 15:33
 * To change this template use File | Settings | File Templates.
 */
package gui.notify {
import gui.GuiComponent;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.Color;
import starling.utils.HAlign;

public class GuiScoreNotify extends GuiComponent {
    private var _timeText:TextField;
    private var _timeTextShadow:TextField;
    private var t:Tween;
    public const _signalCompleted:Signal = new Signal();

    private var _graphics:Sprite;

    public function GuiScoreNotify(score:int) {

        TextField.registerBitmapFont(GraphicsLoader.luneFont14);

        _timeText = new TextField(100,50,"+" + score,"lunetypex14", 25, 0xaef35d);
        _timeText.x = -50;
        _timeText.y = -7;
        _timeTextShadow = new TextField(100,50,"+" + score,"lunetypex14", 25, 0x11350c);
        _timeTextShadow.x = -48;
        _timeTextShadow.y = -5;

        if (score < 0) {
            _timeText.color = 0xff2a3e;
            _timeText.text = "" + score;
            _timeTextShadow.text  = "" + score;
        }

        _timeText.hAlign = HAlign.CENTER;
        _timeTextShadow.hAlign = HAlign.CENTER;

        _graphics = new Sprite();
        _graphics.addChild(_timeTextShadow);
        _graphics.addChild(_timeText);

        _graphics.scaleX = _graphics.scaleY = 0.8;

        _graphics.x = 15;
        _graphics.y = -20;
        _graphics.alpha = 0;

        addChild(_graphics)

    }
    public function _animate():void
    {
        t = new Tween(_graphics, 0.3);
        t.scaleTo(1);
        t.moveTo(_graphics.x, _graphics.y-10);
        t.fadeTo(1);
        t.onComplete = changeValueAnimation;
        Starling.juggler.add(t);

    }

    private function changeValueAnimation():void {
        t.reset(_graphics, 0.8);
        t.scaleTo(0.9);
        t.moveTo(_graphics.x, _graphics.y - 5);
        Starling.juggler.add(t);
        t.onComplete = changeValueAnimation2;
    }

    private function changeValueAnimation2():void {
        t.reset(_graphics, 0.5);
        t.scaleTo(0.7);
        t.moveTo(_graphics.x, _graphics.y - 5);
        t.fadeTo(0);
        Starling.juggler.add(t);
        t.onComplete = _completed;
    }

    private function _completed():void
    {
        _signalCompleted.dispatch();
        dispose();
    }
}
}
