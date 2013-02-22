package popups {
import com.bit101.components.List;
import com.bit101.components.PushButton;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import project.ProjectFile;
import project.ProjectTypes;

import projectContent.Image;

import sources.EdObjectType;

import utitilites.EdLevelProvider;

import utitilites.EdObjectProvider;

public class ObjectPopUp {

    private var m_graphics:Sprite;
    private var m_controllingProject:ProjectFile;
    private var component:List;
    private var SIGNAL_LOAD_CLICKED:Signal = new Signal(String);
    private var typeBtn:PushButton;
    public function ObjectPopUp() {
        m_graphics = new Sprite();
        component = new List(m_graphics, 0, 0, EdObjectType._getAll());
//        m_graphics.addChild(component);
        component.addEventListener(Event.SELECT, onSelect);
    }

    private function onSelect(e:Event):void {
        m_controllingProject._object._name = component.selectedItem.toString();
    }

    private function o_clickedLoad(e:MouseEvent):void {
        if (typeBtn.label ==  "switch to LEVELS")
        {
            SIGNAL_LOAD_CLICKED.dispatch(component.selectedItem.toString(), ProjectTypes.OBJECT);
        }
        else
        {
            SIGNAL_LOAD_CLICKED.dispatch(component.selectedItem.toString(), ProjectTypes.LEVEL);

        }
    }

    public function get _loadClicked():Signal
    {
        return SIGNAL_LOAD_CLICKED;
    }
    public function get _graphics():Sprite
    {
        return m_graphics;
    }

    public function set _controllingProject(projectF:ProjectFile):void {
    m_controllingProject = projectF;
        for each (var s:String in component.items)
        {
            if (s == m_controllingProject._object._name)
            {
                component.selectedItem = s;
            }
        }
    }
}
}

