package utitilites
{
	import flash.events.KeyboardEvent;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;


	public class KeyboardCatcher
	{
		private static const SIGNAL_KEY_PRESSED:Signal = new Signal(String);
		private static const SIGNAL_KEY_UNPRESSED:Signal = new Signal(String);
		private static var m_pressedKey:String = "";

		public static function _start()
		{
			Editor._stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			Editor._stage.addEventListener(KeyboardEvent.KEY_UP, keyUnpressed);
		}


		private static function keyUnpressed(e:KeyboardEvent):void
		{
			_signalKeyUnpressed.dispatch(e.keyCode.toString());
			 m_pressedKey = "";
		}


		private static function keyPressed(e:KeyboardEvent):void
		{
            if (m_pressedKey != e.keyCode.toString())
            {
			_signalKeyPressed.dispatch(e.keyCode.toString());
			m_pressedKey = e.keyCode.toString();
            }
		}

		public static function get _signalKeyPressed():Signal
		{
			return SIGNAL_KEY_PRESSED;
		}
		public static function get _signalKeyUnpressed():Signal
		{
			return SIGNAL_KEY_UNPRESSED;
		}

		public static function _isKeyPressed(keyCode:String):Boolean
		{
			if (m_pressedKey == keyCode)
			{
				return true;
			} else
			{
				return false;
			}
		}
	}
}
