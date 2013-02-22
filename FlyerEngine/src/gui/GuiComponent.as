/**
 * Created with IntelliJ IDEA.
 * User: Admin
 * Date: 9.11.2012
 * Time: 15:35
 * To change this template use File | Settings | File Templates.
 */
package gui {
import flash.geom.Point;

import helpers.MathHelp;

import starling.display.Sprite;

public class GuiComponent extends Sprite {

    public function GuiComponent() {

    }

    public function rotate(center:Point):void
    {
        rotation = MathHelp.angle(center.x - x, center.y - y) - Math.PI;
    }
}
}
