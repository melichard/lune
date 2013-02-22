/**
 * Created with IntelliJ IDEA.
 * User: Tomas
 * Date: 20.1.2013
 * Time: 16:28
 * To change this template use File | Settings | File Templates.
 */
package gui.achievements {

import starling.display.Image;
import starling.display.Sprite;

public class MenuAchievementItem {
    public var _graphics:Sprite;
    public function MenuAchievementItem() {
        _graphics = new Sprite();
        var bg:Image = new Image(GraphicsLoader._getGraphicsGUI("menu/acheviements_item"));
        bg.pivotX = bg.width/2;
        bg.pivotY = bg.height/2;
        _graphics.addChild(bg);

    }
}
}
