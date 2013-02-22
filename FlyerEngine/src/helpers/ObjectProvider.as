package helpers {
import flash.geom.Point;
import flash.utils.ByteArray;

import objects.GameObject;
import objects.Polygon;

public class ObjectProvider {
    [Embed(source='/../../config/objectDefinitions.xml', mimeType="application/octet-stream")]
    private static var _xml:Class;

    private static var _objectXml:XML;

    public static function load():void
    {
        var ba:ByteArray = (new _xml()) as ByteArray;
        var string:String = ba.readUTFBytes(ba.length);
        _objectXml = new XML(string);
    }

    public static function getPolygon(gameObject:GameObject):Polygon
    {
        var _polygon:Polygon = new Polygon(gameObject);
        for (var i:int = 0; i < _objectXml.Object.length(); i++)
        {
            if (_objectXml.Object[i].@id == gameObject.getId)
            {
                var _xmlPolygon:XMLList = getNodeByID(getNodeByID(_objectXml.Object[i].State, "1").Frame , "1").Polygon.Point;
                for (var j:int = 0; j < _xmlPolygon.length(); j++)
                {
                    var _xmlPoint:XML = getNodeByID(_xmlPolygon, "" + (j+1));
                    _polygon.addPoint(new Point(Number(_xmlPoint.@x),Number(_xmlPoint.@y)));
                }
            }
        }

        return _polygon;
    }

    public static function getStates(gameObject:GameObject):Vector.<Vector.<String>>
    {
        var _states:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
        for (var i:int = 0; i < _objectXml.Object.length(); i++)
        {
            if (_objectXml.Object[i].@id == gameObject.getId)
            {
                var _xmlStates:XMLList = _objectXml.Object[i].State;
                for (var j:int = 0; j < _xmlStates.length(); j++)
                {
                    var _State:Vector.<String> =  new Vector.<String>();
                    var _xmlState:XML = getNodeByID(_xmlStates, "" + (j+1));
                    for (var k:int = 0; k < _xmlState.Frame.length(); k++)
                    {
                        _State.push(getNodeByID(_xmlState.Frame, "" + (k+1)).Image.@id);
                    }

                    _states.push(_State);
                }
            }
        }

        return _states
    }

    public static function getPivots(gameObject:GameObject):Vector.<Vector.<Point>>
    {
        var _pivots:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
        for (var i:int = 0; i < _objectXml.Object.length(); i++)
        {
            if (_objectXml.Object[i].@id == gameObject.getId)
            {
                var _xmlStates:XMLList = _objectXml.Object[i].State;
                for (var j:int = 0; j < _xmlStates.length(); j++)
                {
                    var _State:Vector.<Point> =  new Vector.<Point>();
                    var _xmlState:XML = getNodeByID(_xmlStates, "" + (j+1));
                    for (var k:int = 0; k < _xmlState.Frame.length(); k++)
                    {
                        _State.push(new Point(getNodeByID(_xmlState.Frame, "" + (k+1)).Pivot.@x,getNodeByID(_xmlState.Frame, "" + (k+1)).Pivot.@y ));
                    }

                    _pivots.push(_State);
                }
            }
        }

        return _pivots
    }

    public static function getSquirrelPolygon(gameObject:GameObject):Vector.<Vector.<Polygon>>
    {
        var _polygons:Vector.<Vector.<Polygon>> = new Vector.<Vector.<Polygon>>();
        for (var i:int = 0; i < _objectXml.Object.length(); i++)
        {
            if (_objectXml.Object[i].@id == gameObject.getId)
            {
                var _xmlStates:XMLList = _objectXml.Object[i].State;
                for (var j:int = 0; j < _xmlStates.length(); j++)
                {
                    var _State:Vector.<Polygon> =  new Vector.<Polygon>();
                    var _xmlState:XML = getNodeByID(_xmlStates, "" + (j+1));
                    for (var k:int = 0; k < _xmlState.length(); k++)
                    {
                        var _polygon:Polygon = new Polygon(gameObject);
                        var _xmlPolygon:XMLList = getNodeByID(_xmlState.Frame, "" + (k+1)).Polygon.Point;
                        for (var l:int = 0; l < _xmlPolygon.length(); l++)
                        {
                            var _xmlPoint:XML = getNodeByID(_xmlPolygon, "" + (j+1));
                            _polygon.addPoint(new Point(Number(_xmlPoint.@x),Number(_xmlPoint.@y)));
                        }
                        _State.push(_polygon);
                    }
                    _polygons.push(_State);
                }
            }
        }

        return _polygons;
    }

    private static function getNodeByID(xmlList:XMLList, id:String):XML {
        for (var i:int = 0; i < xmlList.length(); i++) {
            if (xmlList[i].@id == id) {
                return xmlList[i];
            }
        }
        return null;
    }
}
}
