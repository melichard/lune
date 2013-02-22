/**
 * Created with IntelliJ IDEA.
 * User: Tomas
 * Date: 4.2.2013
 * Time: 17:58
 * To change this template use File | Settings | File Templates.
 */
package sources {
public class EdObjectType {
    public static const COLLECTABLE:String = "collectables.Collectable";
    public static const OBSTACLE:String = "obstacles.Obstacle";
    public static const BG_TREE:String = "bg.BgTree";
    public static const BG_HILLS:String = "bg.BgHills";
    public static const BG_CLOUD:String = "bg.BgCloud";
    public static const TREE:String = "bg.Tree";
    public static const RADIOL:String = "obstacles.Radiol";
    public static const CHICK:String = "enemies.Enemy";
    public static const BIRD:String = "collectables.Bird";

    public static function _getAll():Array
    {
        var r:Array = new Array();
        r.push(COLLECTABLE);
        r.push(OBSTACLE);
        r.push(BG_TREE);
        r.push(BG_HILLS);
        r.push(BG_CLOUD);
        r.push(TREE);
        r.push(RADIOL);
        r.push(CHICK);
        r.push(BIRD);

        return r;
    }
}
}
