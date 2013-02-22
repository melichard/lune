package objects.obstacles
{
import objects.*;
	import flash.display.Bitmap;
	import flash.geom.Point;

import org.osflash.signals.Signal;

public class Radiol extends GameObject
	{
		public function Radiol(position:Point, id:String = "tree01f")
		{
			super(position, id);

            _setTexture(_states[_state.x][_state.y]);
            _setPivot (_pivots[_state.x][_state.y]);
		}

        public override function onHit():void
        {
            if (_firstHit)
            {
                _firstHit = false;
            }
        }
	}
}