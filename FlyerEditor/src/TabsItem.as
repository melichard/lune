package {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import org.osflash.signals.Signal;

import utitilites.GuiButton;

public class TabsItem {
    private var textField:TextField;
    private var SIGNAL_CLICKED:Signal = new Signal(String);
    private var SIGNAL_CLOSE:Signal = new Signal(String);
    private var m_graphics:Sprite;
    private var bg:Bitmap;

    public function TabsItem(id:String) {
        m_graphics = new Sprite();
//        m_graphics.buttonMode = true;
//        m_graphics.mouseChildren = false;

        textField = new TextField();
        var textFieldFormat:TextFormat = new TextFormat("Calibri", 10, 0x000000);
        textField.defaultTextFormat = textFieldFormat;
        textField.text = id;
        textField.x = 5;
        textField.y = 0;
        textField.height = 15;
        textField.autoSize = TextFieldAutoSize.LEFT;
        textField.selectable = false;
        bg = new Bitmap(new BitmapData(textField.width + 30, 15, false, 0xffffff));
        var bgspr:Sprite = new Sprite();
        bgspr.addChild(bg);
        bgspr.mouseChildren = false;
        m_graphics.addChild(bgspr);
        bgspr.addChild(textField);
        bgspr.addEventListener(MouseEvent.CLICK, o_clicked);
        var close:GuiButton = new GuiButton(new Editor._xbtn(),new Editor._xbtn())
        close._signalClicked.add(o_closeClicked);
        close._graphics.x = bg.width - 15;
        close._graphics.y = 4;
        close._graphics.buttonMode = true;
        m_graphics.addChild(close._graphics);
    }

    private function o_closeClicked():void {
        SIGNAL_CLOSE.dispatch(textField.text);
    }

    private function o_clicked(event:MouseEvent):void {
        SIGNAL_CLICKED.dispatch(textField.text);
    }

    public function get _graphics():Sprite
    {
        return m_graphics;
    }
    public function get _signalClicked():Signal
    {
        return SIGNAL_CLICKED;
    }

    public function get _signalClose():Signal
    {
        return SIGNAL_CLOSE;
    }

    public function get _id():String {
        return textField.text;
    }


    public function set _active(active:Boolean):void {
        if (active)
        {
            bg.alpha = 1;
            textField.alpha = 1;
        } else {
            bg.alpha = 0.4;
            textField.alpha = 0.5;
        }

    }
}
}
