package popups {
import flash.display.Sprite;
import com.bit101.components.List;

import flash.events.Event;
import flash.utils.getDefinitionByName;

public class LevelPopUp {

    private var m_graphics:Sprite;
    private var component:List;
    public function LevelPopUp() {
        m_graphics = new Sprite();
        var items:Array = new Array("MINI", "SMALL", "MEDIUM", "LARGE");
        component = new List(m_graphics,0,0,items);
        component.addEventListener(Event.SELECT, o_select);
    }
    public function get _graphics():Sprite
    {
        return m_graphics;
    }

    private function o_select(event:Event):void {
        Editor.m_actualProject._level._planet._type = component.selectedIndex + 1;
    }
}
}
