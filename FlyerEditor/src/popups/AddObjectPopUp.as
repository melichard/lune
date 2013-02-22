package popups {
import com.bit101.components.List;
import com.bit101.components.PushButton;

import flash.display.Sprite;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import utitilites.EdObjectProvider;

public class AddObjectPopUp {
    private var m_graphics:Sprite;
    private var SIGNAL_LOAD_CLICKED:Signal = new Signal(String);
    private var component:List;

    public function AddObjectPopUp() {
        m_graphics = new Sprite();
//        m_graphics.addChild(component);
//        component.addEventListener(Event.SELECT, onSelect);
        EdObjectProvider._signalLoaded.add(fill);
        var loadBtn:PushButton = new PushButton(m_graphics, 0, 120, "ADD", o_clickedLoad);
    }

    private function o_clickedLoad(e:MouseEvent):void {
        Editor.m_shownPopup = "";
        Editor.m_popup.visible = false;
        SIGNAL_LOAD_CLICKED.dispatch(component.selectedItem.toString());
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

