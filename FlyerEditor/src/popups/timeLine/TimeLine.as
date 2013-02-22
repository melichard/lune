package popups.timeLine {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.utils.clearInterval;

import org.osflash.signals.Signal;

import projectContent.states.StateLine;

import projectContent.states.StatesObject;

public class TimeLine {

    [Embed("../../../assets/TLElement.png")]
    const BmpTle:Class;
    [Embed("../../../assets/TLElement_new.png")]
    const BmpTleNew:Class;
    [Embed("../../../assets/TLElement_active.png")]
    const BmpTleAct:Class;

    private var bitmapTle:BitmapData = new BmpTle().bitmapData;
    private var bitmapTleNew:BitmapData = new BmpTleNew().bitmapData;
    private var bitmapTleAct:BitmapData = new BmpTleAct().bitmapData;

    private var counts:Array;
    private var m_graphics:Sprite;
    private var m_actualLine:int;
    private var m_actualItem:int;
    private var m_actualSprite:Sprite;
    private const SIGNAL_CHANGED:Signal = new Signal(int, int);
    private const SIGNAL_ADD_ITEM:Signal = new Signal(int, int);
    public function TimeLine() {
        m_graphics = new Sprite();
    }

    public function set _statesObject(statesObject:StatesObject):void
    {
        clear();
        counts = new Array(statesObject._states.length);
        for each (var line:StateLine in statesObject._states)
        {
            counts[line._id-1] = line._length;
            for (var i:int = 0; i < line._length; i++)
            {
                var itemSpr:Sprite = new Sprite();

                var item:Bitmap = new Bitmap(bitmapTle.clone());
                itemSpr.x = (line._id - 1)*20;
                itemSpr.y = (i)*20;
                itemSpr.addEventListener(MouseEvent.CLICK, o_itemClicked);
                itemSpr.addChild(item);
                m_graphics.addChild(itemSpr);
            }

            var plusSpr:Sprite = new Sprite();
            var plus:Bitmap = new Editor._plus();
            plusSpr.addChild(plus);
            plusSpr.y = (line._length)*20;
            plusSpr.x = (line._id - 1)*20;
            plusSpr.buttonMode = true;
            plusSpr.addEventListener(MouseEvent.CLICK,  o_plusClicked);
            m_graphics.addChild(plusSpr);

        }
    }

    private function clear():void {

        while (m_graphics.numChildren > 0) {
            m_graphics.removeChild(m_graphics.getChildAt(m_graphics.numChildren - 1));
        }
    }

    private function o_plusClicked(event:MouseEvent):void {
        SIGNAL_ADD_ITEM.dispatch((event.target.x/20 + 1), (event.target.y/20 + 1));
    }

    private function o_itemClicked(e:MouseEvent):void {
        _setActual((e.currentTarget.x/20)+1,(e.currentTarget.y/20)+1);
    }

    public function _setActual(line:int, item:int)
    {
        m_actualLine = line;
        m_actualItem = item;

        if (m_actualSprite)
        {
            (m_actualSprite.getChildAt(0) as Bitmap).bitmapData = bitmapTle.clone();
        }
        for (var i:int = 0; i < m_graphics.numChildren; i++)
        {
            var frame:DisplayObject = m_graphics.getChildAt(i);
            if ((frame.x == (line-1)*20) && (frame.y == (item-1)*20))
            {
                ((frame as Sprite).getChildAt(0) as Bitmap).bitmapData = bitmapTleAct.clone();
                m_actualSprite = (frame as Sprite);
            }
        }

        _onChanged.dispatch(m_actualLine, m_actualItem);
    }

    public function get _signalAddItem():Signal
    {
        return SIGNAL_ADD_ITEM;
    }
    public function get _graphics():Sprite
    {
        return m_graphics;
    }

    public function get _onChanged():Signal
    {
        return SIGNAL_CHANGED;
    }
}
}
