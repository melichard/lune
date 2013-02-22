/**
 * Created with IntelliJ IDEA.
 * User: Derp
 * Date: 16.10.12
 * Time: 22:03
 * To change this template use File | Settings | File Templates.
 */
package helpers {
import flash.events.Event;
import flash.filesystem.File;
import flash.media.Sound;
import flash.net.URLRequest;

public class SoundHelper {
    public static var nutTaken:Sound;
    public static var boostTaken:Sound;
    public static var hitTaken:Sound;
    private static var soundtrack:Sound;

    public static function load():void
    {
//        var file:File = File.applicationDirectory.resolvePath("collect_orech.mp3");
//        nutTaken = new Sound();
//        nutTaken.load(new URLRequest(file.url));
//        file = File.applicationDirectory.resolvePath("collect_boost.wav");
//        boostTaken = new Sound();
//        boostTaken.load(new URLRequest(file.url));
//        file = File.applicationDirectory.resolvePath("obstacle_hit.wav");
//        hitTaken = new Sound();
//        hitTaken.load(new URLRequest(file.url));
    }


    public static function playSound(id:String):void
    {
//        if (id == "nutt")
//        nutTaken.play();
//        else if (id == "boost")
//        boostTaken.play();
//        else if (id == "hit")
//        hitTaken.play();
    }

    public static function playSoundTrack():void
        {
//            var file:File = File.applicationDirectory.resolvePath("test" +
//                    ".mp3");
//            soundtrack = new Sound();
//            soundtrack.load(new URLRequest(file.url));
//            soundtrack.addEventListener(Event.COMPLETE, soundtrackLoaded);
    }

    private static function soundtrackLoaded(event:Event):void {
//        soundtrack.play(0, 9999);
    }
}
}