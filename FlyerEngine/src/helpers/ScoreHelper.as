/**
 * Created with IntelliJ IDEA.
 * User: Derp
 * Date: 11.7.12
 * Time: 19:58
 * To change this template use File | Settings | File Templates.
 */
package helpers {
import gui.GuiScore;
import gui.notify.GuiScoreNotify;

public class ScoreHelper {
    public static const _nuttxS:int = 100;
    public static const _nuttS:int = 50;
    public static var _guiScore:GuiScore;
    public static var _score:int;

    public static function _initGuiScore():void
    {
        _score = 0;
        if (!_guiScore)
        {
            _guiScore = new GuiScore();
        }
        else
        {
            _guiScore._set(0);
        }
    }

    public static function _plus(score:int):void {
        _guiScore._set(_score + score);
        _score+=score;
    }
}
}
