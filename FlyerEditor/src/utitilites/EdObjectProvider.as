package utitilites {
import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.geom.Point;
import flash.net.URLLoader;
import flash.net.URLRequest;

import org.osflash.signals.Signal;

import projectContent.Image;
import projectContent.polygon.PolygonObject;
import projectContent.polygon.PolygonPoint;
import projectContent.states.StateItem;
import projectContent.states.StateLine;

public class EdObjectProvider {

    private static var m_idArray:Array;
    private static var _atlas_xml:XML;
    public static var _signalLoaded:Signal = new Signal();

    public static function _load():void {
//        _atlas_xml = XML(new _xml());
//
        m_idArray = new Array();
//        for (var i:int=0; i<_atlas_xml.SubTexture.length(); i++) {
//            m_idArray[i] = (_atlas_xml.SubTexture[i].@id);
//        }

        var file:File = File.applicationDirectory;
        file = file.resolvePath("app:/data/objectDefinitions.xml");
        var xmlLoader:URLLoader = new URLLoader();
        xmlLoader.addEventListener(Event.COMPLETE, loaded);
        xmlLoader.load(new URLRequest(file.url));
        file = null;
    }

    private static function loaded(e:Event):void {
        XML.ignoreWhitespace = true;
        _atlas_xml = new XML(e.target.data);
        for (var i:int = 0; i < _atlas_xml.Object.length(); i++) {
            m_idArray[i] = (_atlas_xml.Object[i].@id);
        }
        _signalLoaded.dispatch();
    }

    public static function saveObject(object:EdGameObject) {
        var savedXml:XML = _atlas_xml;
        var objectXml:XML;
        var newItem:Boolean = false;
        var onePolygon:Boolean = false;

        for (var i:int = 0; i < savedXml.Object.length(); i++) {
            trace("a: " + savedXml.Object[i].@id, "b: " + object._id);
            if (savedXml.Object[i].@id == object._id) {
                objectXml = savedXml.Object[i];
                delete savedXml.Object[i];
            }
        }
        if (!objectXml) {
            newItem = true;
        }
        objectXml = new XML(<Object />);

        objectXml.@id = object._id;
        objectXml.@onePolygon = onePolygon;
        objectXml.@name = object._name;

        for each (var item:StateLine in object._states._states) {
            var stateXml:XML = new XML(<State />);
            stateXml.@id = item._id;
            for each (var frameItem:StateItem in object._states._getLine(item._id)._items) {
                var frameXml:XML = new XML(<Frame />);
                frameXml.@id = frameItem._id;
                var imageXml:XML = new XML(<Image />);
                imageXml.@id = frameItem._imageID;
                frameXml.appendChild(imageXml);
                if (!onePolygon) {
                    var polygonXml:XML = new XML(<Polygon />);
                    for each (var polygon:PolygonPoint in frameItem._polygon._points) {
                        var pointXml:XML = new XML(<Point />);
                        pointXml.@id = polygon._id;
                        pointXml.@x = polygon._x;
                        pointXml.@y = polygon._y;
                        polygonXml.appendChild(pointXml);

                    }
                    frameXml.appendChild(polygonXml);

                }
                var pivotXml:XML = new XML(<Pivot />);
                pivotXml.@x = frameItem._image._pivot.x;
                pivotXml.@y = frameItem._image._pivot.y;
                frameXml.appendChild(pivotXml);

                stateXml.appendChild(frameXml);
            }
            objectXml.appendChild(stateXml);
        }

        savedXml.appendChild(objectXml);
        var filePath:String = "app:/data/objectDefinitions.xml";
        var appDirFile:File = new File(filePath);
        var xmlFile:File = new File(appDirFile.nativePath);
        var fileStream:FileStream = new FileStream();
        fileStream.open(xmlFile, FileMode.WRITE);
        fileStream.writeUTFBytes(savedXml.toXMLString());
        fileStream.close();

        _atlas_xml = savedXml;
    }

    public static function getPolygon(id:String) {

    }

    public static function getObject(id:String):EdGameObject {
        for (var i:int = 0; i < _atlas_xml.Object.length(); i++) {
            if (_atlas_xml.Object[i].@id == id) {
                if (_atlas_xml.Object[i].@name)
                {
                    var obj:EdGameObject = new EdGameObject(id, _atlas_xml.Object[i].@name);
                }
                else {
                    var obj:EdGameObject = new EdGameObject(id);

                }
                var frameList:XMLList = getNodeByID(_atlas_xml.Object[i].State, "1").Frame;
                obj._states._getLine(1)._getItem(1)._image = new Image(GraphicsLoader.getBitmapData(getNodeByID(frameList, "1").Image.@id));
                obj._states._getLine(1)._getItem(1)._image._imageID = getNodeByID(frameList, "1").Image.@id;
                obj._states._getLine(1)._getItem(1)._polygon = new PolygonObject();
                obj._states._getLine(1)._getItem(1)._image._pivot = new Point( getNodeByID(frameList, "1").Pivot.@x,  getNodeByID(frameList, "1").Pivot.@y);
                for (var j:int = 0; j < getNodeByID(getNodeByID(_atlas_xml.Object[i].State, "1").Frame, "1").Polygon.Point.length(); j++) {
                    var pointXML:XML = getNodeByID(getNodeByID(frameList, "1").Polygon.Point, (j + 1).toString());
                    obj._states._getLine(1)._getItem(1)._polygon._add(new PolygonPoint(int(pointXML.@id), new Point(Number(pointXML.@x), Number(pointXML.@y))));
                }
                for (var j:int = 0; j < _atlas_xml.Object[i].State.length(); j++) {
                    var stLine:StateLine = new StateLine();
                    stLine._id = int(_atlas_xml.Object[i].State[j].@id);


                    if (stLine._id != 1)
                    {

                        obj._states._addLine(stLine);
                    } else {
                        stLine = obj._states._getLine(1);
                    }

                    for (var k:int = 0; k < _atlas_xml.Object[i].State[j].Frame.length(); k++) {
                        var stItem:StateItem = new StateItem();
                        stItem._id = int(_atlas_xml.Object[i].State[j].Frame[k].@id);
                        stItem._image = new Image(GraphicsLoader.getBitmapData(_atlas_xml.Object[i].State[j].Frame[k].Image.@id));
                        stItem._image._imageID = _atlas_xml.Object[i].State[j].Frame[k].Image.@id;
                        stItem._polygon = new PolygonObject();
                        stItem._image._pivot = new Point( _atlas_xml.Object[i].State[j].Frame[k].Pivot.@x, _atlas_xml.Object[i].State[j].Frame[k].Pivot.@y);
                        for (var l:int = 0; l < _atlas_xml.Object[i].State[j].Frame[k].Polygon.Point.length(); l++) {
                            var pointXML:XML = getNodeByID(_atlas_xml.Object[i].State[j].Frame[k].Polygon.Point, (l + 1).toString());
                            if (_atlas_xml.Object[i].@onePolygon as Boolean)
                            {
                                stItem._polygon._disabled();
                            } else
                            {
                                stItem._polygon._add(new PolygonPoint(int(pointXML.@id), new Point(Number(pointXML.@x), Number(pointXML.@y))));
                            }

                        }
                        if (!(stLine._id == 1 && stItem._id == 1)) {
                            stLine._addItem(stItem);

                        }
                    }
                }
//                for (var j:int = 1; j<_atlas_xml.Object[i].State.length(); j++)
//                {
//                    obj._states._addLine()
//                    obj._states._getLine(1)._getItem(1)._image = new Image(GraphicsLoader.getBitmapData(getNodeByID(frameList, "1").Image.@id));
//                    obj._states._getLine(1)._getItem(1)._polygon = new PolygonObject();
//                    for ( var j:int = 0; j< getNodeByID(getNodeByID(_atlas_xml.Object[i].State, "1").Frame, "1").Polygon.Point.length(); j++)
//                    {
//                        var pointXML:XML = getNodeByID(getNodeByID(frameList, "1").Polygon.Point, (j + 1).toString());
//                        obj._states._getLine(1)._getItem(1)._polygon._add(new PolygonPoint(int(pointXML.@id), new Point(Number(pointXML.@x), Number(pointXML.@y))));
//                    }
//                }
            }
        }
        return obj;
    }

    private static function getNodeByID(xmlList:XMLList, id:String):XML {
        for (var i:int = 0; i < xmlList.length(); i++) {
            if (xmlList[i].@id == id) {
                return xmlList[i];
            }
        }
        return null;
    }

    public static function getNames():Array {
        return m_idArray;
    }
}
}
