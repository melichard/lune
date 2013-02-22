package screen {
import flash.display.Bitmap;

import helpers.SharedSpace;

import org.osflash.signals.ISignal;

import org.osflash.signals.Signal;

import starling.display.Image;

import starling.display.Sprite;

import starling.events.Touch;

import starling.events.TouchEvent;
import starling.events.TouchPhase;

import starling.text.TextField;

public class StageScreen extends Screen
{
    private var _toLevelS:Signal;

    private var _movement:Number;
    private var _inertia:Boolean;

    private var _stageButtons:Vector.<Sprite>;

    public function StageScreen() {
        super(new Bitmap(new spaceB()));

        _toLevelS = new Signal();

        _inertia = false;

        _initStageButtons();

        _initBack(100,300);

        addEventListener(starling.events.TouchEvent.TOUCH,  _onTouch);

        }

    protected override function _onFrame():void
    {
        if (_inertia)
        {
            if (_movement < 0)
                _movement++;
            else
                _movement--;
            if (_movement)
                x += _movement;
            if (_movement == 0)
                _inertia = false;
        }

        if (x < -700)
            x = -700;
        if (x > 700)
            x = 700;
    }

    private function _onTouch(e:starling.events.TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch)
            if (touch.phase == TouchPhase.MOVED)
            {
                _movement = Math.round(touch.getMovement(this).x);
                if (_movement)
                    x += _movement;
            } else if (touch.phase == TouchPhase.ENDED)
            {
                _inertia = true;
            }
    }



    private function _initStageButtons():void
    {
        _stageButtons = new Vector.<Sprite>();
        for (var i:int = 0; i < 5; i++)
        {
            var locked:Boolean = false;
            var button:Sprite = new Sprite();
            _stageButtons.push(button)
            _stageButtons[i].addChild(new starling.text.TextField(100,50,"stage"+i));
            _stageButtons[i].x = 100*i;

            if (i > 0)
            {
                for (var j:int = (i-1)*20; j < ((i-1)*20 + 20); j++)
                {
                    if (SharedSpace.getScoreOfLevel(j) == 0)
                    {
                        locked = true;
                        break;
                    }
                }
            }

            if (locked)
            {
                var lock:Image = new Image(GraphicsLoader.exit);
                _stageButtons[i].addChild(lock);
            } else
            {
                _stageButtons[i].addEventListener(starling.events.TouchEvent.TOUCH,_toStage);
            }
            addChild(_stageButtons[i]);
        }
    }

    private function _toStage (e:starling.events.TouchEvent):void{
        var touch:Touch = e.getTouch(stage);
        if (touch.phase == TouchPhase.ENDED)
        {
            for (var i:int = 0; i < 5; i++)
            {
                if (touch.globalX >= _stageButtons[i].x && touch.globalX <= _stageButtons[i].x + _stageButtons[i].width)
                {
                    _toLevelS.dispatch(i+1);
                }
            }
        }
    }

    public function get toLevelS():ISignal
    {
        return _toLevelS;
    }

    }
}
