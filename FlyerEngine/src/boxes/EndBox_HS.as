package boxes {
import org.osflash.signals.Signal;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class EndBox_HS extends Sprite{
    private var boxTexture:Image;

    private var _pauseS:Signal;
    private var _exitS:Signal
    private var _redoS:Signal;

    private var _redoButton:Image;

    private var _exitButton:Image;

    public function EndBox_HS() {

        boxTexture = new Image(GraphicsLoader.endBox);
        addChild(boxTexture);

        _pauseS = new Signal();
        _redoS = new Signal();
        _exitS = new Signal();

        _redoButton = new Image(GraphicsLoader.redo);
        addChild(_redoButton);

        _exitButton = new Image(GraphicsLoader.exit);
        _exitButton.x = 200;
        addChild(_exitButton);

        x = 330;
        y = 200;

        this.addEventListener(Event.ADDED, _onAdded);

    }

    private function _onAdded(e:starling.events.Event):void
    {
        _pauseS.dispatch();
        _exitButton.addEventListener(TouchEvent.TOUCH,  _onExit);
        _redoButton.addEventListener(TouchEvent.TOUCH,  _onRedo);
    }

    private function _onRedo(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch.phase == TouchPhase.BEGAN)
        {
            _exitButton.removeEventListener(TouchEvent.TOUCH, _onExit);
            _redoButton.removeEventListener(TouchEvent.TOUCH,  _onRedo);
            _redoS.dispatch();
        }
    }


    private function _onExit(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch.phase == TouchPhase.BEGAN)
        {
            _exitButton.removeEventListener(TouchEvent.TOUCH, _onExit);
            _redoButton.removeEventListener(TouchEvent.TOUCH, _onRedo);
            _exitS.dispatch();
        }
    }

    public function get pauseS():Signal
    {
        return _pauseS;
    }

    public function get exitS():Signal
    {
        return _exitS;
    }

    public function get redoS():Signal
    {
        return _redoS;
    }
}
}
