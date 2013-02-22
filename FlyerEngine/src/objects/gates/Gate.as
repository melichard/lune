package objects.gates
{
import objects.*;
	import flash.display.Bitmap;
	import flash.geom.Point;

import org.osflash.signals.Signal;

public class Gate extends GameObject
	{
        public var _signal:Signal;
		public function Gate(position:Point)
		{
			super(position);
            _signal = new Signal();
            _signal.add(_activated);
		}

        public function get signal():Signal
        {
            return _signal;
        }

        private function _activated():void
        {

        }


	}
}