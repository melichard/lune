package screen {
import flash.display.Bitmap;

import helpers.SharedSpace;

import org.osflash.signals.Signal;

import starling.display.Image;
import starling.display.Sprite;

import starling.events.Touch;

import starling.events.TouchEvent;
import starling.events.TouchPhase;

import starling.text.TextField;

public class LevelScreen extends Screen
{
    private var _levelButtons:Vector.<Sprite>;
    private var _levelScreenId:int;

    private var _toGameS:Signal;

    public function LevelScreen(ID:int) {
        super(new Bitmap(new spaceB()));

        _levelScreenId = ID;

        _toGameS = new Signal();

        _initLevelButtons();

        _initBack(100,300);
    }

    protected function _initLevelButtons():void
    {
        _levelButtons = new Vector.<Sprite>();

        var button:Sprite;
        var text:TextField;
        for (var i:int = 0; i < 20; i++)
        {
            SharedSpace.setScoreToLevel(i + (_levelScreenId-1)*20, 900);

            var stars:int = 0;
            var score:int = SharedSpace.getScoreOfLevel(i + (_levelScreenId-1)*20);

            text = new TextField(50,50,"" + (i + 1));
            text.x = 25;
            text.y = 25;

            button = new Sprite();
            button.addChild(new Image(GraphicsLoader.exit));
            button.addChild(text);
            button.x = 80 + 160*(i % 5) + 30;
            button.y = 40 + 125*(Math.floor(i/5)) + 25;
            button.addEventListener(starling.events.TouchEvent.TOUCH, _onLevelButton);

            if (score >= 1000)
                stars = 3;
            else if (score >= 750)
                stars = 2;
            else if (score >= 500)
                stars = 1;

            for (var j:int = 0; j < stars; j++)
            {
                var star:Image = new Image(GraphicsLoader.star);
                star.y = 40;
                star.x = 10 + 30*j;
                button.addChild(star);
            }


            _levelButtons.push(button);
            addChild(button);
        }

    }


    private function _onLevelButton(e:starling.events.TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        var button:Sprite = (e.currentTarget as Sprite);
        if (touch.phase == TouchPhase.BEGAN)
        {
            var id:int = (button.x - 110)/160 + 5*(button.y - 65)/125;
            _toGameS.dispatch((_levelScreenId - 1)*20 + id)
        }

    }

    public function get toGameS():Signal
    {
        return _toGameS;
    }
}
}
