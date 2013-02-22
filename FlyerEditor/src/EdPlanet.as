package {
import flash.display.BitmapData;

import org.osflash.signals.Signal;

public class EdPlanet {

    public static const MINI:int = 1;
    public static const SMALL:int = 2;
    public static const MEDIUM:int = 3;
    public static const LARGE:int = 4;
    private var x:int;
    private var y:int;
    private var SIGNAL_SIZE_CHANGED:Signal = new Signal(BitmapData);
    private var m_size:int;
    private var m_type:int;

    public function EdPlanet() {
    }

    public function get _x():int
    {
        return x;
    }
    public function get _y():int
    {
        return y;
    }
    public function set _y(iy:int):void
    {
        y = iy;
    }
    public function set _x(ix:int):void
    {
        x = ix;
    }

    public function get _size():int {
        return m_size;
    }

    public function set _type(type:int) {
        m_type = type;
        m_size = (type*200+200)/2;
        var bd:BitmapData;
        switch (type)
        {
            case 1:
                bd = GraphicsLoader.getBitmapData("planet_mini");
                m_size = 200;
                break;
            case 2:
                bd = GraphicsLoader.getBitmapData("planet_small");
                m_size = 350;
                break;
            case 3:
                m_size = 480;
                bd = GraphicsLoader.getBitmapData("planet_medium");
                break;
            case 4:

                bd = GraphicsLoader.getBitmapData("planet_large");
                break;
            default:
                bd = GraphicsLoader.getBitmapData("planet_mini");
                break;
        }
        _sizeChanged.dispatch(bd);
    }
    public function get _type():int {
        return m_type;
    }

    public function get _sizeChanged():* {
        return SIGNAL_SIZE_CHANGED;
    }
}
}
