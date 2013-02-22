package tools {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import org.osflash.signals.Signal;

public class ToolsStatic {
    private static var m_tools:Vector.<ToolItem>;
    private static var m_actualTool:ToolItem;
    private static var m_toolbar:Sprite;
    private static var m_toolbarBtns:Vector.<ToolBarBtn>;
    private static var SIGNAL_TOOL_CHANGED:Signal = new Signal();

    public static function _initTools() {
        m_tools = new Vector.<ToolItem>();
        fullFillToolsVector();
        m_actualTool = m_tools[0];
        m_toolbar = new Sprite();
        m_toolbar.y = 240;
        m_toolbar.x = 4;
        m_toolbarBtns = new Vector.<ToolBarBtn>();
        fulFillToolBar();
        m_toolbarBtns[0]._active();
    }

    public static function get _signalToolChanged():Signal
    {
        return SIGNAL_TOOL_CHANGED;
    }
    private static function fulFillToolBar():void {
        var total:int = 0;
        if ((m_tools.length % 2) == 0) {
            for (var i:int = 0; i < m_tools.length / 2; i++) {
                for (var j:int = 0; j < 2; j++) {
                    var spr:ToolBarBtn = new ToolBarBtn(m_tools[i*2 + j])
                    spr._signalClicked.add(o_toolBarBtnClicked);
                    spr._graphics.x = j*(32);
                    spr._graphics.y = i*32;
                    m_toolbar.addChild(spr._graphics);
                    m_toolbarBtns.push(spr);
                }
            }
        } else {
            for (var i:int = 0; i < (m_tools.length + 1)/ 2 ; i++) {
                for (var j:int = 0; j < 2; j++) {
                    if (!((i == (m_tools.length + 1)/ 2 -1) && (j == 1)))
                    {
                        var spr:ToolBarBtn = new ToolBarBtn(m_tools[i*2 + j])
                        spr._signalClicked.add(o_toolBarBtnClicked);
                        spr._graphics.x = j*(32);
                        spr._graphics.y = i*32;
                        m_toolbar.addChild(spr._graphics);
                        m_toolbarBtns.push(spr);
                    }
                }
            }
        }

    }

    private static function o_toolBarBtnClicked(item:ToolItem):void {
        for each (var btn:ToolBarBtn in m_toolbarBtns)
        {
            if (btn._item == item)
            {
                _actualTool = btn._item;
                btn._active();
            }
            else
            {
                btn._deactive();
            }
        }
    }


    private static function fullFillToolsVector():void {
        m_tools.push(new ToolItem("MOVER"));
        m_tools.push(new ToolItem("POLYGONER"));
    }

    public static function getToolByID(id:String):ToolItem {
        var r:ToolItem;
        for each (var tool:ToolItem in m_tools) {
            if (tool._id == id) {
                r = tool;
            }
        }
        return r;
    }

    public static function set _actualTool(tool:ToolItem):void {
        m_actualTool = tool;
        SIGNAL_TOOL_CHANGED.dispatch();
    }

    public static function get _tools():Vector.<ToolItem> {
        return m_tools;
    }

    public static function get _actualTool():ToolItem {
        return m_actualTool;
    }

    public static function _getToolbar():Sprite {
        return m_toolbar;
    }
}
}
