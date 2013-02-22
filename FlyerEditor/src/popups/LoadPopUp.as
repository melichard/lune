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

import utitilites.EdLevelProvider;

import utitilites.EdObjectProvider;

public class LoadPopUp {

    private var m_graphics:Sprite;
    private var m_controllingProject:ProjectFile;
    private var component:List;
    private var SIGNAL_LOAD_CLICKED:Signal = new Signal(String);
    private var typeBtn:PushButton;
    public function LoadPopUp() {
        m_graphics = new Sprite();
//        m_graphics.addChild(component);
//        component.addEventListener(Event.SELECT, onSelect);
        EdObjectProvider._signalLoaded.add(fill);
        var loadBtn:PushButton = new PushButton(m_graphics, 0, 120, "LOAD", o_clickedLoad);
        typeBtn = new PushButton(m_graphics, 0, 140, "switch to LEVELS", o_change);
    }

    private function o_change(e:MouseEvent):void {
        if (typeBtn.label ==  "switch to LEVELS")
        {
            typeBtn.label = "switch to OBJECTS";
            component = new List(m_graphics, 0, 0, EdLevelProvider.getNames());

        } else {
            typeBtn.label = "switch to LEVELS";
            component = new List(m_graphics, 0, 0, EdObjectProvider.getNames());
        }
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

    private function fill():void {
        component = new List(m_graphics, 0, 0, EdObjectProvider.getNames());
    }

    public function get _loadClicked():Signal
    {
        return SIGNAL_LOAD_CLICKED;
    }
    public function get _graphics():Sprite
    {
        return m_graphics;
    }
}
}

