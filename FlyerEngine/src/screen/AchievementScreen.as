package screen {
import flash.display.Bitmap;

import helpers.AchievDefinitions;

import helpers.SharedSpace;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

public class AchievementScreen extends Screen{

    private var _achievementBoxes:Vector.<Sprite>;

    private var _content:Sprite;

    private var _movement:Number;
    private var _inertia:Boolean;

    public function AchievementScreen() {
        super(new Bitmap(new spaceB()));

        _content = new Sprite();
        addChild(_content);

        _inertia = false;

        _initBack(100,300);

        _initAchievBoxes();

        addEventListener(TouchEvent.TOUCH,  _onTouch);

    }

    private function _initAchievBoxes():void
    {
        _achievementBoxes = new Vector.<Sprite>();

        var achievBox:Sprite;

        for (var i:int = 0; i < 10; i++)
        {
            achievBox = new Sprite();

            var bckgroundImage:Image;
            if (SharedSpace.getAchievement(i))
                bckgroundImage = new Image(GraphicsLoader.endBox);
            else
                bckgroundImage = new Image(GraphicsLoader.endBox2);
            achievBox.addChild(bckgroundImage);
            achievBox.width = 500;
            achievBox.height = 100;
            achievBox.x = 230;
            achievBox.y = 120 + 130*i;

            var text:TextField = new TextField(400,30, AchievDefinitions["_" + i]);
            achievBox.addChild(text);

            _achievementBoxes.push(achievBox);
            _content.addChild(achievBox);
        }

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
                _content.y += _movement;
            if (_movement == 0)
                _inertia = false;
        }

        if (_content.y < -700)
            _content.y = -700;
        if (_content.y > 0)
            _content.y = 0;
    }

    private function _onTouch(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch)
            if (touch.phase == TouchPhase.MOVED)
            {
                _movement = Math.round(touch.getMovement(this).y);
                if (_movement)
                    _content.y += _movement;
            } else if (touch.phase == TouchPhase.ENDED)
            {
                _inertia = true;
            }
    }
}
}
