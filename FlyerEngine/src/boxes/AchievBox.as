/**
 * Created with IntelliJ IDEA.
 * User: Derp
 * Date: 2.7.12
 * Time: 22:25
 * To change this template use File | Settings | File Templates.
 */
package boxes {
import helpers.AchievDefinitions;
import helpers.OnFrame;

import org.osflash.signals.Signal;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.text.TextField;

public class AchievBox extends Sprite {

        private var boxTexture:Image;

        private var cancelButton:Image;

        private var content:Sprite;

        private var _onEndS:Signal;

        private var _count:int;

        public function AchievBox(id:int) {
            boxTexture = new Image(GraphicsLoader.pauseBox);
            addChild(boxTexture);

            content = new Sprite();
            addChild(content);

            cancelButton = new Image(GraphicsLoader.exit);
            cancelButton.x = 0;
            cancelButton.y = 0;
            addChild(cancelButton);

            var text:TextField = new TextField(400,30, AchievDefinitions["_" + id]);
            addChild(text);

            x = 0;
            y = -200;
            width = 960;
            height = 200;

            _onEndS = new Signal();

            _count = 0;

            this.addEventListener(Event.ADDED, _onAdded);
        }

        private function _onAdded(e:Event):void
        {
            OnFrame.frameS.add(_onShowFrame);
            cancelButton.addEventListener(TouchEvent.TOUCH,  _onShowFrame);
        }

    private function _onShowFrame():void
    {
        y += 10;
        if (y == 0)
        {
            OnFrame.frameS.remove(_onShowFrame);
            OnFrame.frameS.add(_onShowedFrame);
        }
    }

    private function _onShowedFrame():void
    {
        _count++;
        if (_count == 200)
        {
            OnFrame.frameS.remove(_onShowedFrame);
            OnFrame.frameS.add(_onHideFrame);
            _count = 0;
        }
    }

    private function _onHideFrame():void
    {
        y -= 10;
        if (y == -200)
        {
            OnFrame.frameS.remove(_onHideFrame);
            _onEndS.dispatch();
        }
    }

    public function get onEndS():Signal
    {
        return _onEndS;
    }

}
}
