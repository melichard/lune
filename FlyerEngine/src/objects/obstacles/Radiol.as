package objects.obstacles
{
import flump.display.Movie;

import helpers.MathHelp;

import objects.*;
	import flash.display.Bitmap;
	import flash.geom.Point;

import org.osflash.signals.Signal;

import starling.core.Starling;
import starling.display.Image;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class Radiol extends GameObject
	{
    private var movie:Movie;
    private var line:Movie;
    private var hitEff:Movie;


    public function Radiol(position:Point, id:String = "tree01f")
		{
			super(position, id, 300);

//            _setTexture(_states[_state.x][_state.y]);
//            _setPivot (_pivots[_state.x][_state.y]);

            var bg:Image = GraphicsLoader._getImageFromLibrary("RedRadiolBg");
            addChild(bg);
            movie = GraphicsLoader._getMovieFromLibrary("RadioFlying");

            movie.x = 0;
            movie.y = 0;
            movie.stop();

            Starling.juggler.add(movie);

            addChild(movie)

            hitEff = GraphicsLoader._getMovieFromLibrary("HitEffect");
            addChild(hitEff);
            hitEff.stop();
            Starling.juggler.add(hitEff);

            line = GraphicsLoader._getMovieFromLibrary("LightningLine");
            addChild(line);
            line.stop();
            Starling.juggler.add(line);
		}


        public override function onHit():void
        {
            if (_firstHit)
            {
                _firstHit = false;
                effect (this.globalToLocal(_hitPoint))
            }
        }

        private function effect(p:Point):void
        {

            // p prepisat na global

            hitEff.x = p.x;
            hitEff.y = p.y;

            line.scaleX = MathHelp.prepona(p.x,  p.y)/80;
            line.x = p.x/2;
            line.y = p.y/2;
            line.rotation = MathHelp.angle(p.x, p.y) + Math.PI*3/2;

            line.playOnce();
            movie.stop();
            hitEff.stop();
            movie.goTo(0);
            hitEff.goTo(0);
            hitEff.playOnce();
            movie.playOnce();


        }
	}
}