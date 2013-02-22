package screen
{
import boxes.CreditsBox;

import flash.display.Bitmap;

import helpers.OnFrame;

import helpers.SharedSpace;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.display.Image;

import starling.display.Image;
import starling.events.Event;

import starling.events.Touch;

import starling.events.TouchEvent;
import starling.events.TouchPhase;

import starling.text.TextField;

public class MenuScreen extends Screen
	{
        private var _toStageS:Signal;

        private var _toAchievS:Signal;

        private var _creditsButton:Image;

        private var _creditsBox:CreditsBox;

        private var _playButton:Image;

        private var _achievButton:Image;

        private var _fadeCounter:int;

		public function MenuScreen()
		{
			super(new Bitmap());

            _toStageS = new Signal();

            _initBackgroundAnimation();

            _initPlayButton();

            _fadeCounter = 0;

            SharedSpace.setAchievement(1);

            this.addEventListener(Event.ADDED, _onAdded);
		}

    private function _initBackgroundAnimation():void {
        var background:Image = Image(GraphicsLoader._getGraphicsGUI("menu_background"));
        addChild(background);
        background.x = 480;
        background.y = 270;
    }

        private function _onAdded(e:Event):void
        {
            OnFrame.frameS.add(_fadeIn);
        }

        private function _fadeIn():void
        {
            _fadeCounter++;
            _playButton.alpha += 0.1;
            if (_playButton.alpha > 1)
                _playButton.alpha = 1;
            if (_fadeCounter > 10)
            {
                _achievButton.alpha += 0.1;
                if (_achievButton.alpha > 1)
                    _achievButton.alpha = 1;
                _creditsButton.alpha += 0.1;
                if (_creditsButton.alpha > 1)
                    _creditsButton.alpha = 1;
            }
        }

        private function _toStage (e:starling.events.TouchEvent):void{
            var touch:Touch = e.getTouch(stage);
            if (touch.phase == TouchPhase.ENDED)
            {
                _toStageS.dispatch();
            }
        }

        private function _initCreditsButton():void
        {
            _creditsButton = new Image(GraphicsLoader.pause);
            _creditsButton.alpha = 0;
            _creditsButton.x = 0;
            _creditsButton.y = 500;
            _creditsButton.addEventListener(TouchEvent.TOUCH, _onCredits);
            addChild(_creditsButton);
        }

        private function _initPlayButton():void
        {
            _playButton = new Image(GraphicsLoader.resume);
            _playButton.alpha = 0;
            _playButton.x = 480;
            _playButton.y = 200;
            _playButton.addEventListener(TouchEvent.TOUCH, _toStage);
            addChild(_playButton);
        }

        private function _initAchievButton():void
        {
            _achievButton = new Image(GraphicsLoader.pause);
            _achievButton.alpha = 0;
            _achievButton.x = 400;
            _achievButton.y = 500;
            _achievButton.addEventListener(TouchEvent.TOUCH, _onAchiev);
            addChild(_achievButton);
        }

        private function _onCredits(e:TouchEvent):void
        {
            var touch:Touch = e.getTouch(stage);
            if (touch)
                if (touch.phase == TouchPhase.BEGAN)
                {
                    removeChild(_creditsButton);
                    addChild(_creditsBox);
                }
        }

        private function _onAchiev(e:TouchEvent):void
        {
            var touch:Touch = e.getTouch(stage);
            if (touch)
                if (touch.phase == TouchPhase.BEGAN)
                {
                    removeChild(_achievButton);
                    _toAchievS.dispatch();
                }
        }

        private function _onCancelCredits():void
        {
            removeChild(_creditsBox);
            addChild(_creditsButton);
        }


        public function get toStageS():ISignal
        {
            return _toStageS;
        }

        public function get toAchievS():ISignal
        {
            return _toAchievS;
        }
	}
}