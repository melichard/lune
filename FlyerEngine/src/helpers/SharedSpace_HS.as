/**
 * Created with IntelliJ IDEA.
 * User: Derp
 * Date: 6.7.12
 * Time: 10:43
 * To change this template use File | Settings | File Templates.
 */
package helpers {
import flash.net.SharedObject;

public class SharedSpace_HS {
    private static var _sharedSpace:SharedObject = SharedObject.getLocal("LuneHS");
    public static function getTopScore():Array
    {
        var scores:Array = new Array();
        return scores;
    }

    public static function setScore(position:int, score:int):void
    {
        _sharedSpace.data[position - 1] = score;
        _sharedSpace.flush();
    }

    public static function setAchievement(id:int):void
    {
        _sharedSpace.data[id + 200] = true;
        _sharedSpace.flush();
    }

    public static function getAchievement(id:int):Boolean
    {
        return (_sharedSpace.data[id + 200]);
    }

    public static function setAchievementData(id:int, score:int):void
    {
        _sharedSpace.data[id + 400] += score;
        _sharedSpace.flush();
    }

    public static function getAchievementData(id:int):int
    {
        return (_sharedSpace.data[id + 400]);
    }


}
}
