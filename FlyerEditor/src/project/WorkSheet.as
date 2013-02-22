package project
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
import flash.events.MouseEvent;


public class WorkSheet
	{
		private var m_width:int;
		private var m_height:int;
		private var m_graphics:Sprite;
		private var background:Bitmap;

		public function WorkSheet(width:int, height:int)
		{
			m_width = width;
			m_height = height;
			m_graphics = new Sprite();
			background = new Bitmap(new BitmapData(width,  height,  false, 0xdddddd));
			background.x = -width/2;
			background.y = -height/2;
			m_graphics.addChild(background);
            m_graphics.addEventListener(MouseEvent.MOUSE_WHEEL, o_mWheel);
		}

        private function o_mWheel(event:MouseEvent):void {
            m_graphics.scaleX = (event.delta/3)*0.1 + m_graphics.scaleX;
            m_graphics.scaleY = (event.delta/3)*0.1 + m_graphics.scaleY;
//            background.x = -m_graphics.width/2;
//            background.y = -m_graphics.height/2;
        }

		public function get _width():int
		{
			return m_width;
		}

		public function get _height():int
		{
			return m_height;
		}

		public function set _width(width:int):void
		{
			m_width = width;
		}

		public function set _height(height:int):void
		{
			m_height = height;
		}

		public function _add(item:DisplayObject):void
		{
			m_graphics.addChild(item);
		}

		public function _remove(item:DisplayObject):void
		{
			m_graphics.removeChild(item);
		}

		public function get _graphics():Sprite
		{
			return m_graphics;
		}

        public function _clear():void
        {
            while(m_graphics.numChildren > 0)
            {
                m_graphics.removeChild(m_graphics.getChildAt(m_graphics.numChildren-1));
            }
            m_graphics.addChild(background);
        }
	}
}
