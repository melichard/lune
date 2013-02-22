package screen
{
import flash.display.Bitmap;

import helpers.OnFrame;

import org.osflash.signals.Signal;

import starling.display.BlendMode;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
	
	
	public class Screen extends starling.display.Sprite
	{
		protected var background:Image;

        protected var _backS:Signal;

        protected var back:TextField;

		public function Screen(backgroundBmap:Bitmap=null)
		{
            if (backgroundBmap)
            {
                 background = new Image(Texture.fromBitmap(backgroundBmap));
                 background.blendMode = BlendMode.NONE;
                 addChild(background);
            }

             _backS = new Signal();

			 OnFrame.frameS.add(_onFrame);
		}
		
		protected function _onFrame():void
		{
        }


        protected function _initBack(x:Number,  y:Number):void
        {
            back = new TextField(100,50,"menu");
            back.x = x;
            back.y = y;
            back.addEventListener(starling.events.TouchEvent.TOUCH,_back);
            addChild(back);
        }


        protected function _back (e:starling.events.TouchEvent):void{
            var touch:Touch = e.getTouch(stage);
            if (touch.phase == TouchPhase.ENDED)
            {
                _backS.dispatch();
            }
        }

        public function get backS():Signal
        {
            return _backS;
        }


		
	}
}