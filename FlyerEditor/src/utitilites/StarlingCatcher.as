package utitilites {
import flash.display.BitmapData;
import flash.geom.Point;
import flash.utils.getDefinitionByName;

import helpers.OnFrame;

import maps.Map;

import objects.GameObject;
import objects.Planet;
import objects.bg.BgCloud;
import objects.bg.BgHills;
import objects.bg.BgTree;
import objects.bg.Tree;
import objects.collectables.Bird;
import objects.collectables.Collectable;
import objects.obstacles.Obstacle;
import objects.obstacles.Radiol;

import org.osflash.signals.Signal;

import screen.GameScreen;
import screen.GameScreen_HS;

import starling.display.Image;

import starling.display.Image;

import starling.display.Sprite;
import starling.display.Stage;
import starling.events.Event;
import starling.textures.Texture;

public class StarlingCatcher extends Sprite {
    private static const Signal_Added:Signal = new Signal();
    private static var m_stage:Stage;
    private static var graphics:Sprite;
    public static var playing:Boolean = false;
    private static var gameScreen:GameScreen;

    public function StarlingCatcher() {
        addEventListener(Event.ADDED_TO_STAGE, added);
    }

    private function added(e:Event):void {
        m_stage = this.stage;
        graphics = this;
        Collectable;
        Obstacle;
        BgCloud;
        BgTree;
        Tree;
        BgHills;
        Bird;
        Radiol;
        Signal_Added.dispatch();
    }

    public static function get _onAdded():Signal {
        return Signal_Added;
    }

    public static function _startGame(level:EdGameLevel):void
    {
        var objectsv:Vector.<GameObject> = new Vector.<GameObject>();
        for each (var item:EdGameObject in level._objects)
        {

            var _class:Class = getDefinitionByName("objects." + item._name) as Class;
            var go:GameObject = new _class(new Point(item._states._getLine(1)._getItem(1)._image.x + 480, item._states._getLine(1)._getItem(1)._image.y + 400 + level._planet._y), item._id);
            objectsv.push(go);
        }
        var planet:Planet = new Planet(level._planet._size);
        var map:Map = new CustomMap(objectsv, planet);
        gameScreen = new GameScreen(m_stage, 1, map);
        Editor._update.add(OnFrame.frameS.dispatch);
        graphics.addChild(gameScreen);
        playing = true;
    }

    public static function _endGame():void
    {
        playing = false;
        graphics.removeChild(gameScreen);
        Editor._update.remove(OnFrame.frameS.dispatch);
        gameScreen.dispose();
        gameScreen = null;
    }

    public static function _add():void {
        graphics.addChild(new Image(GraphicsLoader.getFrame("00")));

    }
}
}
