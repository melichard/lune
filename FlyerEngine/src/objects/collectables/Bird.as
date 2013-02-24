package objects.collectables {

import flump.display.Movie;

import gui.notify.GuiScoreNotify;

import helpers.OnFrame;
import helpers.ScoreHelper;
import helpers.SoundHelper;

import objects.*;

import flash.geom.Point;
import org.osflash.signals.Signal;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;

public class Bird extends GameObject
{


    public function Bird(Position:Point, id:String = "nutt0")
    {
        super(Position, id);

//        _setTexture(_states[_state.x][_state.y]);
//        _setPivot (_pivots[_state.x][_state.y]);

//        if (_id == "nutt0")
//            _score = 50;
//        else if (_id == "nutt1")
//            _score = 75;
//        else if (_id == "nutt2")
//            _score = 100;
//        else if (_id == "nutt3")
//            _score = 150;



        var random:int = Math.floor(Math.random()*10);
        if (random < 5)
        var movie :Movie = GraphicsLoader._getMovieFromLibrary("BirdGT");
        else
        var movie :Movie = GraphicsLoader._getMovieFromLibrary("BirdRT");

        movie.x = 0;
        movie.y = 0;
        movie = movie.loop();

        Starling.juggler.add(movie);

        addChild(movie)

    }

    public override function onHit():void
    {
       if (_id == "nutt0" || _id == "nutt1" || _id == "nutt2" || _id == "nutt3")
       {
           if (_firstHit)
           {
               _firstHit = false;
               SoundHelper.playSound("nutt");
               //var vibe:Vibration;
               //if (Vibration.isSupported)
               //{
               //    vibe = new Vibration();
               //    vibe.vibrate(2000);
               //}
               var t:Tween = new Tween(_texture, 0.4);
               t.fadeTo(0)
               t.scaleTo(0.6);
               Starling.juggler.add(t);
               t.onComplete = _collected;
           }
       } else if (_id == "boostr" || _id == "boosty" || _id == "boostg" || _id == "boostb")
       {
           if (_firstHit)
           {
               _firstHit = false;
               SoundHelper.playSound("boost");
               var eff:Image = new Image(GraphicsLoader.getFrame("collectables/boostcollected"));
               eff.pivotX = eff.width/2;
               eff.pivotY = eff.height/2;
               this.addChild(eff);
               eff.scaleX = eff.scaleY = 0.5;
               eff.x = _texture.width/2;
               eff.y = _texture.height/2;
               t = new Tween(eff, 1);
               t.fadeTo(0)
               t.scaleTo(2);
               Starling.juggler.add(t);
               var t2:Tween = new Tween(_texture, 0.6);
               t2.fadeTo(0)
               t2.scaleTo(0.6);
               Starling.juggler.add(t2);
           }
       }
    }

    private function _collected():void
    {
        isHit = true;
    }
}
}
