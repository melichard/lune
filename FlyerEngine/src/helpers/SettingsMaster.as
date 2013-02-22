/**
 * Created with IntelliJ IDEA.
 * User: Tomas
 * Date: 22.1.2013
 * Time: 11:41
 * To change this template use File | Settings | File Templates.
 */
package helpers {
import starling.display.Stage;

public  class SettingsMaster {
    public static var _screenWidth:Number;
    public static var _screenHeight:Number;
    public function SettingsMaster() {
    }

    public static function registerConsts(s:Stage):void
    {
        _screenWidth = s.stageWidth;
        _screenHeight = s.stageHeight;
        trace(_screenWidth, _screenHeight);
    }
}
}
