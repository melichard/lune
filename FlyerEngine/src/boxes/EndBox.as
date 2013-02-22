package boxes {


import org.osflash.signals.Signal;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class EndBox extends Sprite{
    private var boxTexture:Image;

    private var _pauseS:Signal;
    private var _exitS:Signal
    private var _redoS:Signal;
    private var _nextS:Signal;

    private var _redoButton:Image;

    private var _exitButton:Image;

    private var _nextButton:Image;

    public function EndBox() {

        boxTexture = new Image(GraphicsLoader.endBox);
        addChild(boxTexture);

        _pauseS = new Signal();
        _redoS = new Signal();
        _exitS = new Signal();
        _nextS = new Signal();

        _redoButton = new Image(GraphicsLoader.redo);
        addChild(_redoButton);

        _exitButton = new Image(GraphicsLoader.exit);
        _exitButton.x = 200;
        addChild(_exitButton);

        _nextButton = new Image(GraphicsLoader.resume);
        _nextButton.x = 300;
        addChild(_nextButton);

        width = 300;
        height = 200;
        x = 330;
        y = 200;

        this.addEventListener(Event.ADDED, _onAdded);

    }

    private function _onAdded(e:starling.events.Event):void
    {
        _pauseS.dispatch();
        _exitButton.addEventListener(TouchEvent.TOUCH,  _onExit);
        _redoButton.addEventListener(TouchEvent.TOUCH,  _onRedo);
        _nextButton.addEventListener(TouchEvent.TOUCH,  _onNext);
    }

    private function _onRedo(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch)
            if (touch.phase == TouchPhase.BEGAN)
            {
                _exitButton.removeEventListener(TouchEvent.TOUCH, _onExit);
                _redoButton.removeEventListener(TouchEvent.TOUCH,  _onRedo);
                _nextButton.removeEventListener(TouchEvent.TOUCH, _onNext);
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
            _nextButton.removeEventListener(TouchEvent.TOUCH, _onNext);
            _exitS.dispatch();
        }
    }

    private function _onNext(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch.phase == TouchPhase.BEGAN)
        {
            _exitButton.removeEventListener(TouchEvent.TOUCH, _onExit);
            _redoButton.removeEventListener(TouchEvent.TOUCH, _onRedo);
            _nextButton.removeEventListener(TouchEvent.TOUCH, _onNext);
            _nextS.dispatch();
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

    public function get nextS():Signal
    {
        return _nextS;
    }
}
}
