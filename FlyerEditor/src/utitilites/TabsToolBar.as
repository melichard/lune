package utitilites {
import flash.display.Sprite;

import org.osflash.signals.Signal;

public class TabsToolBar {

    private var m_graphics:Sprite;
    private var m_tabs:Vector.<TabsItem>;
    private var SIGNAL_ITEM_CLICKED:Signal = new Signal(String);
    private var SIGNAL_ITEM_CLOSE_CLICKED:Signal = new Signal(String);
    public function TabsToolBar() {
        m_tabs = new Vector.<TabsItem>();
        m_graphics = new Sprite();
    }

    public function get _graphics():Sprite
    {
        return m_graphics;
    }

    public function _add(id:String):void
    {
        var item:TabsItem = new TabsItem(id);
        m_graphics.addChild(item._graphics);
        item._signalClicked.add(o_itemClicked);
        item._signalClose.add(o_itemClose);
        var total:int = 0;
        for each (var tab:TabsItem in m_tabs)
        {
            total += tab._graphics.width + 5;
        }
        m_tabs.push(item);
        item._graphics.x = total;
    }

    public function _remove(id:String):void
    {
        var removing:TabsItem;
        var tabs:Vector.<TabsItem> = new Vector.<TabsItem>();
        for each (var tab:TabsItem in m_tabs)
        {
            if (tab._id == id)
            {
                removing = tab;
                m_graphics.removeChild(tab._graphics);
            } else {
                tabs.push(tab);
            }
        }

        for each (var tab:TabsItem in tabs)
        {
            if (tab._graphics.x > removing._graphics.x)
            {
                tab._graphics.x -= removing._graphics.width + 5;
            }
        }

        m_tabs  = tabs;

    }

    private function o_itemClicked(id:String):void {
        SIGNAL_ITEM_CLICKED.dispatch(id);
    }

    private function o_itemClose(id:String):void {
        SIGNAL_ITEM_CLOSE_CLICKED.dispatch(id);
    }

    public function get _itemClicked():Signal
    {
        return SIGNAL_ITEM_CLICKED;
    }

    public function _setActive(id:String):void {
        for each (var tab:TabsItem in m_tabs)
        {
            if (tab._id == id)
            {
                tab._active = true;
            } else
            {
                tab._active = false;
            }

        }
    }

    public function get _itemCloseClicked():Signal {
        return SIGNAL_ITEM_CLOSE_CLICKED;
    }
}
}
