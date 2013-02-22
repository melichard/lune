/**
 * Created with IntelliJ IDEA.
 * User: Tomas
 * Date: 17.1.2013
 * Time: 21:44
 * To change this template use File | Settings | File Templates.
 */
package gui {

import helpers.OnFrame;

import starling.animation.Tween;

import starling.core.Starling;
import starling.core.starling_internal;

import starling.display.Image;
import starling.display.Sprite;

public class MenuLogoLune extends Sprite {

    private var l:Sprite;
    private var u:Sprite;
    private var n:Sprite;
    private var e:Sprite;
    private var tl:Tween;
    private var _currentTime:int = 0;

    public function MenuLogoLune() {

        l = new Sprite();
        l.addChild(new Image(GraphicsLoader._getGraphicsGUI("menu/menu_logo_l")));
        u = new Sprite();
        u.addChild(new Image(GraphicsLoader._getGraphicsGUI("menu/menu_logo_u")));
        n = new Sprite();
        n.addChild(new Image(GraphicsLoader._getGraphicsGUI("menu/menu_logo_n")));
        e = new Sprite();
        e.addChild(new Image(GraphicsLoader._getGraphicsGUI("menu/menu_logo_e")));

        l.pivotX = l.width/2;
        l.pivotY = l.height/2;
        u.pivotX = u.width/2;
        u.pivotY = u.height/2;
        n.pivotX = n.width/2;
        n.pivotY = n.height/2;
        e.pivotX = e.width/2;
        e.pivotY = e.height/2;

        l.x = -140;
        l.y = -10;
        u.x = -50;
        n.x = 60;
        e.x = 160;

        addChild(l);
        addChild(u);
        addChild(n);
        addChild(e);

        this.alpha = 0;

    }

    public function _animate():void
    {
        OnFrame.frameS.add(update);
        OnFrame.frameS.add(_fadeIn);
    }


    private function _fadeIn():void {
        this.alpha += 0.01;
        if (this.alpha == 1)
        {
            OnFrame.frameS.remove(_fadeIn);
        }

    }


    private function update():void {

        l.y = -10 + Math.sin(_currentTime/100)*8;
        u.y = Math.sin((_currentTime+50)/100)*8;
        n.y = Math.sin((_currentTime+100)/100)*8;
        e.y = Math.sin((_currentTime+150)/100)*8;

        _currentTime++;
    }
}
}
