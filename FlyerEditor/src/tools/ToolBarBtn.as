package tools {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class ToolBarBtn {
    private var m_graphics:Sprite;
    private var m_bmp:Bitmap;
    private var m_id:ToolItem;
    private var SIGNAL_CLICKED:Signal = new Signal(ToolItem);

    public function ToolBarBtn(id:ToolItem) {
        m_graphics = new Sprite();
        m_bmp = new Editor.tool_btn();
        m_graphics.addChild(m_bmp);
        m_graphics.addEventListener(MouseEvent.CLICK, o_click);
        m_id = id;
        setIcon()
    }

    private function setIcon():void {
        var bmp:Bitmap;
        switch (m_id._id)
        {
            case "MOVER":
                    bmp = new Editor.tool_mover();
                break;
            case "POLYGONER":
                    bmp = new Editor.tool_polygoner();
                break;
            default:
                    bmp = new Bitmap(new BitmapData(22,22,false,0xff0000));
                break;
        }
        bmp.x = 4;
        bmp.y = 4;
        m_graphics.addChild(bmp);
    }

    private function o_click(e:MouseEvent):void {
        SIGNAL_CLICKED.dispatch(m_id);
    }

    public function get _graphics():Sprite
    {
        return m_graphics;
    }

    public function _active():void
    {
        m_bmp.bitmapData = (new Editor.tool_btn_active()).bitmapData;
    }

    public function _deactive():void
    {
        m_bmp.bitmapData = (new Editor.tool_btn()).bitmapData;
    }

    public function get _signalClicked():Signal
    {
        return SIGNAL_CLICKED;
    }

    public function get _item():ToolItem {
        return m_id;
    }
}
}
