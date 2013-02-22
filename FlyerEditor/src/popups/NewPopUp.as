package popups {
import com.bit101.components.Component;
import com.bit101.components.PushButton;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

import org.osflash.signals.Signal;

import project.ProjectTypes;

import utitilites.GuiButton;

public class NewPopUp {

    [Embed("../../assets/new_level_btn.png")]
    const newLevelBmp:Class;
    [Embed("../../assets/new_object_btn.png")]
    const newObjectBmp:Class;
    private var m_graphics:Sprite;
    private var SIGNAL_NEW:Signal = new Signal(String, String);
    private var newLevel:GuiButton;
    private var newObject:GuiButton;
    private var input:TextField;
    private var nametxt:TextField;
    private var newBtn:PushButton;
    private var type:String;

    public function NewPopUp()
    {
        m_graphics = new Sprite();
        newLevel = new GuiButton(new newLevelBmp(), new newLevelBmp());
        newLevel._signalClicked.add(o_newLevelClicked);
        newLevel._graphics.x = 15;
        newLevel._graphics.y = 15;

        newObject = new GuiButton(new newObjectBmp(), new newObjectBmp());
        newObject._signalClicked.add(o_newObjectClicked);
        newObject._graphics.y = newLevel._graphics.height + 2 + 15;
        newObject._graphics.x = 15;

        m_graphics.addChild(newLevel._graphics);
        m_graphics.addChild(newObject._graphics);

        var tformat:TextFormat;
        tformat = new TextFormat("Calibri", 10, 0x00000);
        input = new TextField();
        input.width = 100;
        input.height = 20;
        input.type = "input";
        input.multiline = false;
        input.defaultTextFormat = tformat;
        input.background = true;
        input.backgroundColor = 0xffffff;
        input.y = 20;
        nametxt = new TextField();
        tformat.color = 0xffffff;
        nametxt.defaultTextFormat = tformat;
        nametxt.text = "name:"
        nametxt.selectable = false;

        newBtn = new PushButton(null, 0, 50, "CREATE!", btnClicked);

    }

    private function btnClicked(e:MouseEvent):void {
        if (input.text != "")
        {
        SIGNAL_NEW.dispatch(type, input.text);
        m_graphics.removeChild(input);
        m_graphics.removeChild(nametxt);
        m_graphics.removeChild(newBtn);
        m_graphics.addChild(newLevel._graphics);
        m_graphics.addChild(newObject._graphics)
        type = "";
            input.text = "";
        }

    }

    private function o_newObjectClicked():void {
        type = ProjectTypes.OBJECT;
        m_graphics.removeChild(newLevel._graphics);
        m_graphics.removeChild(newObject._graphics)
        m_graphics.addChild(nametxt);
        m_graphics.addChild(newBtn);
        m_graphics.addChild(input);
    }

    private function o_newLevelClicked():void {
        type = ProjectTypes.LEVEL;
        m_graphics.removeChild(newLevel._graphics);
        m_graphics.removeChild(newObject._graphics)
        m_graphics.addChild(nametxt);
        m_graphics.addChild(newBtn);
        m_graphics.addChild(input);
    }

    public function get _signalNew():Signal
    {
        return SIGNAL_NEW;
    }

    public function get _graphics():Sprite
    {
        return m_graphics;
    }
}
}
