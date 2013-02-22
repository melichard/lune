package projectContent.states {
import flash.display.BitmapData;

import projectContent.Image;
import projectContent.polygon.PolygonObject;

public class StateItem {

    private var m_stateItemID:int;
    private var m_image:Image;
    private var m_polygonObject:PolygonObject;
    private var m_imageID:String;

    public function StateItem() {
        _image = new Image(new BitmapData(100,100,false,0xcccccc));
        _polygon = new PolygonObject();
        _polygon._setToDefaultObject();
    }

    public function get _image():Image
    {
        return m_image;
    }

    public function get _id():int
    {
        return m_stateItemID;
    }

    public function get _polygon():PolygonObject
    {
        return m_polygonObject;
    }
    public function set _image(image:Image):void
    {
        m_image = image ;
    }
    public function get _imageID():String
    {
        return m_image._imageID;
    }

    public function set _id(id:int):void
    {
        m_stateItemID = id;
    }

    public function set _polygon(polygon:PolygonObject):void
    {
       m_polygonObject = polygon;
    }
}
}
