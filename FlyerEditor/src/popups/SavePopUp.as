package popups {
import com.bit101.components.PushButton;

import flash.display.Sprite;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import project.ProjectFile;

public class SavePopUp {

    private var m_graphics:Sprite;
    private var m_controllingProject:ProjectFile;
    private var component:PushButton;
    private var SIGNAL_SAVE_CLICKED:Signal = new Signal();

    public function SavePopUp() {
        m_graphics = new Sprite();
        component = new PushButton(m_graphics, 0, 0, "SAVE THIS!", o_saveClicked);

    }

    private function o_saveClicked(e:MouseEvent):void {
        SIGNAL_SAVE_CLICKED.dispatch();
    }

    public function get _graphics():Sprite {
        return m_graphics;
    }

    public function get _signalSaveClicked():Signal {
        return SIGNAL_SAVE_CLICKED;
    }

}
}
