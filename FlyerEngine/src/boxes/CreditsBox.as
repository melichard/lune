package boxes {


import helpers.OnFrame;

import org.osflash.signals.Signal;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

public class CreditsBox extends Sprite {
    private var boxTexture:Image;

    private var cancelButton:Image;

    private var content:Sprite;

    private var _cancelS:Signal;

    private var _text:TextField;
    private var _text2:TextField;
    private var _text3:TextField;

    public function CreditsBox() {
        boxTexture = new Image(GraphicsLoader.pauseBox);
        addChild(boxTexture);

        content = new Sprite();
        addChild(content);

        cancelButton = new Image(GraphicsLoader.exit);
        cancelButton.x = 0;
        cancelButton.y = 0;
        addChild(cancelButton);

        _text = new TextField(250, 640, "blablablablabla1");
        _text.y = 0;
        content.addChild(_text);

        _text2 = new TextField(250, 640, "blablablablabla2");
        _text2.y = 640;
        content.addChild(_text2);

        _text3 = new TextField(250, 640, "blablablablabla1");
        _text3.y = 1280;
        content.addChild(_text3);

        x =  -300;
        y = 0;
        width = 300;
        height = 1920;

        _cancelS = new Signal();

        this.addEventListener(Event.ADDED, _onAdded);
    }

    private function _onAdded(e:Event):void
    {
        OnFrame.frameS.add(_onFrame);
        cancelButton.addEventListener(TouchEvent.TOUCH,  _onCancel);
    }

    private function _onFrame():void
    {
        if (x < 0)
            x += 10;
        else if (x == 0)
            content.y -= 5;
        if (content.y == -1280)
            content.y = 0;

    }

    private function _onCancel(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch)
            if (touch.phase == TouchPhase.BEGAN)
            {
                cancelButton.removeEventListener(TouchEvent.TOUCH,  _onCancel);
                OnFrame.frameS.remove(_onFrame);
                OnFrame.frameS.add(_onCancelFrame);

            }
    }

    private function _onCancelFrame():void
    {
        if (x > -300)
            x -= 10;
        else
        {
            OnFrame.frameS.remove(_onCancelFrame);
            _cancelS.dispatch();
        }
    }

    public function get cancelS():Signal
    {
        return _cancelS;
    }
}
}
