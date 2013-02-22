package objects.buttons
{
import objects.*;
import flash.geom.Point;

import objects.gates.Gate;

import org.osflash.signals.Signal;

public class Button extends GameObject
	{
        private var gate:Gate;
		public function Button(position:Point)
		{
			super(position);
		}

        public function setGate(gate:Gate):void
        {
            this.gate = gate;
        }


        public override function onHit():void
        {
            gate.signal.dispatch();
        }
    }
}