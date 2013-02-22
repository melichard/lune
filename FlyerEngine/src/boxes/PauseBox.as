package boxes {
import helpers.OnFrame;

import org.osflash.signals.Signal;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class PauseBox extends Sprite{

    private var _boxTexture:Image;

    private var _resumeButton:Image;

    private var _redoButton:Image;

    private var _exitButton:Image;

    private var _resumeS:Signal;
    private var _exitS:Signal;
    private var _redoS:Signal;
    private var _pauseS:Signal;

    public function PauseBox() {

        _resumeS = new Signal();
        _exitS = new Signal();
        _pauseS = new Signal();
        _redoS = new Signal();

        _boxTexture = new Image(GraphicsLoader.pauseBox);
        addChild(_boxTexture);

        _resumeButton = new Image(GraphicsLoader.resume);
        addChild(_resumeButton);
        _resumeButton.y = 20;
        _resumeButton.x = 5;

        _redoButton = new Image(GraphicsLoader.redo);
        _redoButton.y = 90;
        _redoButton.x = 5;
        addChild(_redoButton);

        _exitButton = new Image(GraphicsLoader.exit);
        _exitButton.y = 160;
        _exitButton.x = 5;
        addChild(_exitButton);

        x = -200;
        y = 0;

        this.addEventListener(starling.events.Event.ADDED, _onAdded);

    }


    private function _onAdded(e:starling.events.Event):void
    {
        _pauseS.dispatch();
        OnFrame.frameS.add(_onPauseFrame);
    }

    private function _onPauseFrame():void
    {
        x += 10;
        if (x == 0)
        {
            _resumeButton.addEventListener(TouchEvent.TOUCH, _onResume);
            _exitButton.addEventListener(TouchEvent.TOUCH,  _onExit);
            _redoButton.addEventListener(TouchEvent.TOUCH,  _onRedo);
            OnFrame.frameS.remove(_onPauseFrame);
        }
    }

    private function _onResume(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch.phase == TouchPhase.BEGAN)
        {
            _resumeButton.removeEventListener(TouchEvent.TOUCH, _onResume);
            _exitButton.removeEventListener(TouchEvent.TOUCH, _onExit);
            _redoButton.removeEventListener(TouchEvent.TOUCH,  _onRedo);
            OnFrame.frameS.add(_onResumeFrame);
        }
    }

    private function _onRedo(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch.phase == TouchPhase.BEGAN)
        {
            _resumeButton.removeEventListener(TouchEvent.TOUCH, _onResume);
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
            _resumeButton.removeEventListener(TouchEvent.TOUCH, _onResume);
            _exitButton.removeEventListener(TouchEvent.TOUCH, _onExit);
            _redoButton.removeEventListener(TouchEvent.TOUCH,  _onRedo);
            _exitS.dispatch();
        }
    }

    private function _onResumeFrame():void
    {
        x -= 10;
        if (x == -200)
        {
            OnFrame.frameS.remove(_onResumeFrame);
            _resumeS.dispatch();
        }
    }


    public function get resumeS():Signal
    {
        return _resumeS;
    }

    public function get exitS():Signal
    {
        return _exitS;
    }

    public function get pauseS():Signal
    {
        return _pauseS;
    }

    public function get redoS():Signal
    {
        return _redoS;
    }
}
}
