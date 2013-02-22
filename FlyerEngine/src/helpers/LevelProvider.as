package helpers {
import flash.geom.Point;
import flash.utils.ByteArray;
import flash.utils.getDefinitionByName;

import objects.*;
import objects.collectables.Collectable;
import objects.obstacles.Obstacle;

public class LevelProvider {
    [Embed(source='/../../config/levelDefinitions.xml', mimeType="application/octet-stream")]
    private static var _xml:Class;

    private static var _objectXml:XML;

    public static function load():void
    {
        var ba:ByteArray = (new _xml()) as ByteArray;
        var string:String = ba.readUTFBytes(ba.length);
        _objectXml = new XML(string);

        Collectable;
        Obstacle;
    }

    public static function getObjects(mapId:int):Vector.<GameObject>
    {
        var _objects:Vector.<GameObject> = new Vector.<GameObject>();
        var _level:XML = getNodeByID(_objectXml.Level, "" + mapId);
        var _xmlObjects:XMLList = _level.Object;
        for (var i:int = 0; i < _xmlObjects.length(); i++)
        {
            var _class:Class = Obstacle;//getDefinitionByName("objects." + _xmlObjects[i].@classname) as Class;
            var object:GameObject = new _class(new Point(Number(_xmlObjects[i].@x) + 480, Number(_xmlObjects[i].@y) + 320), _xmlObjects[i].@id);
            object._setPivot(new Point(Number(_xmlObjects[i].@pivotX), Number(_xmlObjects[i].@pivotX)));
            _objects.push(object);
        }
        return _objects;
    }

    public static function getPlanet(mapID:int):Planet
    {
        var _planet:Planet;
        var _level:XML = getNodeByID(_objectXml.Level, "" + mapID);
        var _planetXml:XML = _level.Planet[0];
        _planet = new Planet(_planetXml.@size);
        return _planet;
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
