package utitilites {
import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.geom.Point;
import flash.net.URLLoader;
import flash.net.URLRequest;

import maps.Map;

import org.osflash.signals.Signal;

import projectContent.Image;
import projectContent.polygon.PolygonObject;
import projectContent.polygon.PolygonPoint;
import projectContent.states.StateItem;
import projectContent.states.StateLine;

public class EdLevelProvider {

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
        file = file.resolvePath("app:/data/levelDefinitions.xml");
        var xmlLoader:URLLoader = new URLLoader();
        xmlLoader.addEventListener(Event.COMPLETE, loaded);
        xmlLoader.load(new URLRequest(file.url));
        file = null;
    }

    private static function loaded(e:Event):void {
        XML.ignoreWhitespace = true;
        _atlas_xml = new XML(e.target.data);
        for (var i:int = 0; i < _atlas_xml.Level.length(); i++) {
            m_idArray[i] = (_atlas_xml.Level[i].@id);
        }
        _signalLoaded.dispatch();
    }

    public static function saveLevel(level:EdGameLevel) {
        var savedXml:XML = _atlas_xml;
        var levelXml:XML;
        var newLevel:Boolean = false;

        for (var i:int = 0; i < savedXml.Level.length(); i++) {
            trace("a: " + savedXml.Level[i].@id, "b: " + level._id);
            if (savedXml.Level[i].@id == level._id) {
                levelXml = savedXml.Level[i];
                delete savedXml.Level[i];
            }
        }
        if (!levelXml) {
            newLevel = true;
        }
        levelXml = new XML(<Level />);

        levelXml.@id = level._id;

        var planetXml:XML = new XML(<Planet />);
        planetXml.@size = level._planet._size;
        planetXml.@x = level._planet._x;
        planetXml.@y = level._planet._y;
        levelXml.appendChild(planetXml);

        for each (var item:EdGameObject in level._objects) {
            var objectXml:XML = new XML(<Object />);
            objectXml.@id = item._id;
            objectXml.@x = item._states._getLine(1)._getItem(1)._image.x;
            objectXml.@y = item._states._getLine(1)._getItem(1)._image.y + level._planet._y;
            levelXml.appendChild(objectXml);
        }

        savedXml.appendChild(levelXml);
        var filePath:String = "app:/data/levelDefinitions.xml";
        var appDirFile:File = new File(filePath);
        var xmlFile:File = new File(appDirFile.nativePath);
        var fileStream:FileStream = new FileStream();
        fileStream.open(xmlFile, FileMode.WRITE);
        fileStream.writeUTFBytes(savedXml.toXMLString());
        fileStream.close();

        _atlas_xml = savedXml;
    }

    public static function getObjects(mapId:String):Vector.<EdGameObject>
    {
        var _objects:Vector.<EdGameObject> = new Vector.<EdGameObject>();
        var _level:XML = getNodeByID(_atlas_xml.Level, "" + mapId);
        var _xmlObjects:XMLList = _level.Object;
        for (var i:int = 0; i < _xmlObjects.length(); i++)
        {
            var object:EdGameObject = EdObjectProvider.getObject(_xmlObjects[i].@id);
            object._states._getLine(1)._getItem(1)._image.x = _xmlObjects[i].@x;
            object._states._getLine(1)._getItem(1)._image.y = _xmlObjects[i].@y - int(_level.Planet.@y);
            _objects.push(object);
        }
        return _objects;
    }

    public static function getPlanet(mapID:String):EdPlanet
    {
        var _planet:EdPlanet;
        var _level:XML = getNodeByID(_atlas_xml.Level, "" + mapID);
        var _planetXml:XML = _level.Planet[0];
        _planet = new EdPlanet();
        _planet._x = _planetXml.@x;
        _planet._y = _planetXml.@y;
        _planet._type = int(_planetXml.@size)/100 - 1;
        return _planet;
    }

    public static function getLevel(mapID:String):EdGameLevel
    {
        var lvl:EdGameLevel = new EdGameLevel(mapID);
        lvl._planet = getPlanet(mapID);
        lvl._setObjects(getObjects(mapID));
        return lvl;
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

    public static function getMapFromLevel(level:EdGameLevel):Map {
        var r:Map;

        return r;
    }
}
}
