package utitilites
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;


	public class GuiButton
	{

		private var m_graphics:Sprite;
		private var m_bmpHover:Bitmap;
		private var m_bmp:Bitmap;
		private var SIGNAL_CLICKED:Signal = new Signal();
        private var active:Boolean = true;


		public function GuiButton(bmp:Bitmap, bmpHover:Bitmap)
		{
			m_graphics = new Sprite();
			m_bmp = bmp;
			m_bmpHover = bmpHover;
			m_graphics.addChild(m_bmp);
			m_graphics.addChild(m_bmpHover);
			m_bmpHover.alpha = 0;
			m_graphics.addEventListener(MouseEvent.ROLL_OVER, o_over);
			m_graphics.addEventListener(MouseEvent.ROLL_OUT, o_out);
			m_graphics.addEventListener(MouseEvent.CLICK, o_click);
		}


		private function o_click(e:MouseEvent):void
		{
            if (active)
            {
			SIGNAL_CLICKED.dispatch();
                }
		}


		private function o_out(e:MouseEvent):void
		{
			m_bmpHover.alpha = 0;
		}


		private function o_over(e:MouseEvent):void
		{
			m_bmpHover.alpha = 1;
		}


		public function get _graphics():Sprite
		{
			return m_graphics;
		}


		public function get _signalClicked():ISignal
		{
			return SIGNAL_CLICKED;
		}

        public function set _active(bool:Boolean):void
        {
            if (bool)
            {
                m_graphics.alpha = 1;
                active = true;
            }
            else
            {
                active = false;
                m_graphics.alpha = 0.3;
            }
        }
	}
}

