/**
 * Created with IntelliJ IDEA.
 * User: Tomas
 * Date: 18.1.2013
 * Time: 14:49
 * To change this template use File | Settings | File Templates.
 */
package gui {

import gui.achievements.MenuAchievementItem;

import helpers.OnFrame;

import starling.display.DisplayObject;

import starling.display.Image;
import starling.display.Sprite;

public class MenuAchievementsBar extends Sprite {
    private var m_acievements:Vector.<MenuAchievementItem>;
    private var m_selector:Sprite;

    public function MenuAchievementsBar() {
       var background:Image = new Image(GraphicsLoader._getGraphicsGUI("menu/menu_achievements_background"));
        background.pivotX = background.width/2;
        background.pivotY = background.height/2;
        addChild(background);

        _fillAchievements();
       _drawAchievements();
        _drawSelector();

        OnFrame.frameS.add(_fadeIn);

        this.alpha = 0;
    }

    private function _fadeIn():void {
        this.alpha += 0.01;
        if (this.alpha == 1)
        {
            OnFrame.frameS.remove(_fadeIn);
        }

    }

    private function _drawSelector():void {
        m_selector = new Sprite();
        var selector:Image = new Image(GraphicsLoader._getGraphicsGUI("menu/menu_achievements_over"));
        selector.pivotX = selector.width/2;
        selector.pivotY = selector.height/2;
        m_selector.addChild(selector);
        addChild(m_selector);
    }

    private function _fillAchievements():void {
        m_acievements = new Vector.<MenuAchievementItem>();
        for (var i:int=0; i<11; i++)
        {
            m_acievements.push(new MenuAchievementItem());
        }
    }

    private function _drawAchievements():void {
        var i:int = 0;
        for each (var a:MenuAchievementItem in m_acievements)
        {
            addChild(a._graphics);
            a._graphics.x = -70*5 + i*70;
            i++;
        }
    }
}
}
