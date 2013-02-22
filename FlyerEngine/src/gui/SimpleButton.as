/**
 * Created with IntelliJ IDEA.
 * User: Tomas
 * Date: 17.1.2013
 * Time: 21:23
 * To change this template use File | Settings | File Templates.
 */
package gui {



import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.display.Image;


import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

public class SimpleButton extends Sprite {
    private var _graphics:Image;
    private var SIGNAL_CLICKED:Signal = new Signal();
    private var _normalState:Texture;
    private var _secondState:Texture;

    public function SimpleButton(normalState:Texture, secondState:Texture=null) {

        _normalState = normalState;
        _secondState = secondState;
        _graphics = new Image(normalState);
        _graphics.addEventListener(TouchEvent.TOUCH, _clicked);
        addChild(_graphics);
        _graphics.x = -normalState.width/2;
        _graphics.y = -normalState.height/2;
    }

    private function _clicked(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch)
        {


        if (touch.phase == TouchPhase.BEGAN)
        {
            if (_secondState)
            _graphics.texture = _secondState;
        }
        if (touch.phase == TouchPhase.ENDED)
        {
            _graphics.texture = _normalState;
            signalClicked.dispatch();
        }
        }
    }

    public function get signalClicked():Signal
    {
        return SIGNAL_CLICKED;
    }
}
}
