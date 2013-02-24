package objects.obstacles
{
import flump.display.Movie;

import objects.*;
	import flash.display.Bitmap;
	import flash.geom.Point;

import org.osflash.signals.Signal;

import starling.core.Starling;
import starling.display.Image;

public class Radiol extends GameObject
	{
		public function Radiol(position:Point, id:String = "tree01f")
		{
			super(position, id);

//            _setTexture(_states[_state.x][_state.y]);
//            _setPivot (_pivots[_state.x][_state.y]);

            var bg:Image = GraphicsLoader._getImageFromLibrary("RedRadiolBg");
            addChild(bg);
                var movie :Movie = GraphicsLoader._getMovieFromLibrary("RadioFlying");

            movie.x = 0;
            movie.y = 0;
            movie.stop();

            Starling.juggler.add(movie);

            addChild(movie)
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