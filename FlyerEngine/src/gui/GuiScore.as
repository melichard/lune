/**
 * Created with IntelliJ IDEA.
 * User: Podracky
 * Date: 20.11.2012
 * Time: 12:15
 * To change this template use File | Settings | File Templates.
 */
package gui {
import helpers.SettingsMaster;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.Color;
import starling.utils.HAlign;

public class GuiScore extends GuiComponent {

    private var _timeText:TextField;
    private var _timeTextShadow:TextField;
    private var t:Tween;
    private var _score:int;
    private var _image:Image;
    private var _textHolder:Sprite;

    public function GuiScore() {

        TextField.registerBitmapFont(GraphicsLoader.luneFont);

        _timeText = new TextField(300,60,"00","lunetypex", 50, Color.WHITE);
        _timeText.x = -150;
        _timeText.y = -30;
        _timeTextShadow = new TextField(300,60,"00","lunetypex", 50);
        _timeTextShadow.x = -148;
        _timeTextShadow.y = -28;

        _timeText.hAlign = HAlign.RIGHT;
        _timeTextShadow.hAlign = HAlign.RIGHT;

        _textHolder = new Sprite();
        _textHolder.addChild(_timeTextShadow);
        _textHolder.addChild(_timeText);

        _image = new Image( GraphicsLoader.scoreNutt);
        addChild(_image);
        _image.x = 130;
        _image.y = -60;
        this.x = SettingsMaster._screenWidth - 250;
        this.y = 40;
        addChild(_textHolder);
    }



    public function _set(score:int):void
    {
            t = new Tween(_textHolder, 0.1);
            t.scaleTo(0.9);
            _score = score;

            t.onComplete = changeValueAnimation;

            Starling.juggler.add(t);


    }

    private function changeValueAnimation():void {
        _timeText.text = "" + _score;
        _timeTextShadow.text = "" + _score;
        t.reset(_textHolder, 0.1);
        t.scaleTo(1);
        Starling.juggler.add(t);
    }

}
}
