package helpers {
import flash.net.SharedObject;

public class SharedSpace {
    private static var _sharedSpace:SharedObject = SharedObject.getLocal("Lune");
    public static function setScoreToLevel(id:int,  score:int):void
    {
        _sharedSpace.data[id] = score;
        _sharedSpace.flush();
    }

    public static function getScoreOfLevel(id:int):int
    {
        return (_sharedSpace.data[id]);
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
