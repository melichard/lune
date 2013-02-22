package objects.enemies
{
import objects.*;
import flash.geom.Point;

import org.osflash.signals.Signal;

public class Enemy extends GameObject
	{
		public function Enemy(position:Point)
		{
			super(position);
		}
		
		public override function onHit():void
		{
		}
	}
}