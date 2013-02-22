package {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DisplacementMapFilterMode;
import flash.geom.Point;
import flash.ui.Keyboard;

import flashx.textLayout.EditClasses;

import org.osflash.signals.Signal;

import projectContent.Image;

import sources.EdObjectType;

import utitilites.KeyboardCatcher;

import utitilites.EdObjectProvider;
import utitilites.helpers.MathHelp;

public class EdGameLevel {
    private var m_graphicsDef:Sprite;
    private var b_adding:Boolean = false;
    private var m_draggin:Image;
    private var m_dragginObj:EdGameObject;
    private var m_objects:Vector.<EdGameObject>;
    private var m_id:String;
    private var m_planet:EdPlanet;
    private var rotating:String = "";
    private var SIGNAL_SELECTED_CHANGED:Signal = new Signal(EdGameObject);
    private var m_objectsGraphicsDef:Sprite;

    private var planetBmp:Bitmap = new Bitmap();
    private var m_spriteBgHills:Sprite;
    private var m_spriteBgClouds:Sprite;
    private var m_spriteBgTrees:Sprite;
    private var m_spriteTrees:Sprite;
    private var m_spriteMain:Sprite;

    private var planetSprite:Sprite;

    public function EdGameLevel(id:String) {
        m_objects = new Vector.<EdGameObject>();
        m_graphicsDef = new Sprite();
        m_objectsGraphicsDef = new Sprite();
        Editor._update.add(update);
        m_id = id;
//        Editor._stage.addEventListener(MouseEvent.CLICK, click);
        KeyboardCatcher._signalKeyPressed.add(click);
        KeyboardCatcher._signalKeyUnpressed.add(unclick);

        planetSprite  = new Sprite();
        m_planet = new EdPlanet();
        m_planet._sizeChanged.add(changePlanetBmp);
        m_planet._type = EdPlanet.MEDIUM;
        _planet = m_planet;
        planetSprite.addChild(planetBmp);
        m_graphicsDef.mouseChildren = true;
        m_graphicsDef.addChild(m_objectsGraphicsDef);
        m_graphicsDef.addChild(planetSprite);

        m_spriteBgHills = new Sprite();
        m_spriteBgClouds = new Sprite();
        m_spriteBgTrees = new Sprite();
        m_spriteTrees = new Sprite();
        m_spriteMain = new Sprite();

        m_spriteBgHills.mouseChildren = true;
        m_spriteBgHills.mouseEnabled = true;
        m_spriteBgClouds.mouseChildren = true;
        m_spriteBgClouds.mouseEnabled = true;
        m_spriteBgTrees.mouseChildren = true;
        m_spriteBgTrees.mouseEnabled = true;
        m_spriteTrees.mouseChildren = true;
        m_spriteTrees.mouseEnabled = true;
        m_spriteMain.mouseChildren = true;
        m_spriteMain.mouseEnabled = true;
        m_objectsGraphicsDef.mouseChildren = true;
        m_objectsGraphicsDef.mouseEnabled = true;
        m_objectsGraphicsDef.addChild(m_spriteBgHills);
        m_objectsGraphicsDef.addChild(m_spriteBgClouds);
        m_objectsGraphicsDef.addChild(m_spriteBgTrees);
        m_objectsGraphicsDef.addChild(m_spriteTrees);
        m_objectsGraphicsDef.addChild(m_spriteMain);
        m_objectsGraphicsDef.addChild(new Bitmap(new BitmapData(2,2,false,0xffffff)));
        m_objectsGraphicsDef.y = m_planet._y;
    }

    public function set _planet(planet:EdPlanet):void
    {
       m_planet = planet;
       m_planet._sizeChanged.add(changePlanetBmp);
    }


    public function get _planet():EdPlanet
    {
        return m_planet;
    }

    private function changePlanetBmp(bdata:BitmapData):void {
        planetBmp.bitmapData = bdata;
        planetBmp.x =-planetBmp.width/2;
        planetBmp.y =-planetBmp.height/2
        planetSprite.y = 150+ m_planet._size;
        m_planet._x = 0;
        m_planet._y = m_planet._size+ 150;
        trace(m_planet._size);
        m_objectsGraphicsDef.y = m_planet._y;
    }

    public function get _objects():Vector.<EdGameObject>
    {
        return m_objects;
    }
    private function unclick(e:String):void {
        if (e == "65" || "68")
        {
            rotating = "";
        }
    }

    private function click(e:String):void {
        if (this == Editor.m_actualProject._level)
        {
            if (b_adding)
        {
            _addObject(m_dragginObj);
        }
            if (e == String(Keyboard.S))
            {
                rotating = "right";
            }
            else if (e == String(Keyboard.A))
            {
                rotating = "left";
            }
            else if (e == String(Keyboard.D))
            {
                deselectAll();
            }
            else if (e == String(Keyboard.DELETE))
            {
                for each (var item:EdGameObject in m_objects)
                {
                    if (item._states._getLine(1)._getItem(1)._image.selected)
                    {
                        _removeObject(item);
                    }
                }
            }
        }

    }

    private function _addObject(obj:EdGameObject):void {
        obj._states._getLine(1)._getItem(1)._image._signalClick.add(objClick);
        m_objects.push(obj);

        _addImageOfObjectOnScene(obj);
    }

    private function objClick(item:Image):void {
        for each (var imgs:EdGameObject in m_objects)
        {
            imgs._states._getLine(1)._getItem(1)._image.selected = false;
            if (imgs._states._getLine(1)._getItem(1)._image == item)
            {
                imgs._states._getLine(1)._getItem(1)._image.selected = true;
                SIGNAL_SELECTED_CHANGED.dispatch(imgs);
            }
        }
    }

    private function _removeObject(obj:EdGameObject):void
    {
        _removeImageOfObjectFromScene(obj._states._getLine(1)._getItem(1)._image);
        var objects:Vector.<EdGameObject> = new Vector.<EdGameObject>();
        for each(var item:EdGameObject in m_objects)
        {
            if (item != obj)
            {
                objects.push(item);
            }
        }
        m_objects = objects;
    }


    private function _removeImageOfObjectFromScene(image:Image):void
    {
        m_objectsGraphicsDef.removeChild(image);
    }

    private function _addImageOfObjectOnScene(obj:EdGameObject):void
    {
        var image:Image = obj._states._getLine(1)._getItem(1)._image;
        if (b_adding)
        {
            b_adding = false;
            m_draggin = null;
            m_dragginObj = null;
            image._signalMoving.add(rotatingObjectMoving);
        }
        else
        {
            rotatingObjectMoving(image);
           image._signalMoving.add(rotatingObjectMoving);
            switch (obj._name)
            {
                case EdObjectType.BG_HILLS:
                    m_spriteBgHills.addChild(image);
                    break;
                case EdObjectType.BG_TREE:
                    m_spriteBgTrees.addChild(image);
                    break;
                case EdObjectType.BG_CLOUD:
                    m_spriteBgClouds.addChild(image);
                    break;
                case EdObjectType.TREE:
                    m_spriteTrees.addChild(image);
                    break;
                default:
                    m_spriteMain.addChild(image);
                    break;
            }
        }
    }

    private function rotatingObjectMoving(img:Image):void {
        img.rotation = (MathHelp.angle(img.x, img.y))*(360/(Math.PI*2));

    }

    private function update():void {
        if (b_adding)
        {

            switch (m_dragginObj._name)
               {
            case EdObjectType.BG_HILLS:
                var p:Point = new Point(this.m_spriteBgHills.mouseX , this.m_spriteBgHills.mouseY);
                MathHelp.rotatePoint(p, new Point(0, 0), -this.m_spriteBgHills.rotation);
                break;
            case EdObjectType.BG_TREE:
                var p:Point = new Point(this.m_spriteBgTrees.mouseX , this.m_spriteBgTrees.mouseY);
                MathHelp.rotatePoint(p, new Point(0, 0), -this.m_spriteBgTrees.rotation);
                break;
            case EdObjectType.BG_CLOUD:
                var p:Point = new Point(this.m_spriteBgClouds.mouseX , this.m_spriteBgClouds.mouseY);
                MathHelp.rotatePoint(p, new Point(0, 0), -this.m_spriteBgTrees.rotation);
                break;
            case EdObjectType.TREE:
                var p:Point = new Point(this.m_spriteTrees.mouseX , this.m_spriteTrees.mouseY);
                MathHelp.rotatePoint(p, new Point(0, 0), -this.m_spriteTrees.rotation);
                break;
            default:
                var p:Point = new Point(this.m_spriteMain.mouseX , this.m_spriteMain.mouseY);
                MathHelp.rotatePoint(p, new Point(0, 0), -this.m_spriteMain.rotation);
                break;
            }
            m_draggin.x = p.x;
            m_draggin.y = p.y
            m_draggin.rotation = (MathHelp.angle(m_draggin.x, m_draggin.y))*(360/(Math.PI*2));
//            trace(m_draggin.rotation)
        }
        if ((rotating == "right") || (rotating == "left"))
        { var angle:Number;
                if (rotating == "right")
                {
                    angle = 1.5;
                } else
                {
                    angle = -1.5;

                }

            planetSprite.rotation += angle;
                m_spriteMain.rotation += angle;
                m_spriteTrees.rotation += angle;
                m_spriteBgTrees.rotation += angle/1.2;
                m_spriteBgClouds.rotation += angle/1.4;
                m_spriteBgHills.rotation += angle/1.8;
        }
    }
    public function _setObjects(objects:Vector.<EdGameObject>):void
    {
        m_objects = objects;
        for each (var item:EdGameObject in m_objects)
        {
            item._states._getLine(1)._getItem(1)._image._signalClick.add(objClick);
            _addImageOfObjectOnScene(item);
        }
    }


    public function get _graphicsDefinition():Sprite
    {
        return m_graphicsDef;
    }

    public function _simaluteAdd(id:String):void
    {
        b_adding = true;
        var obj:EdGameObject = EdObjectProvider.getObject(id);

        var img:Image = obj._states._getLine(1)._getItem(1)._image;
        img.x = Editor.m_actualProject._sheet._graphics.mouseX;
        img.y = Editor.m_actualProject._sheet._graphics.mouseY;
        m_draggin = img;
        m_dragginObj = obj;
        switch (obj._name)
        {
            case EdObjectType.BG_HILLS:
                m_spriteBgHills.addChild(img);
                break;
            case EdObjectType.BG_TREE:
                m_spriteBgTrees.addChild(img);
                break;
            case EdObjectType.BG_CLOUD:
                m_spriteBgClouds.addChild(img);
                break;
            case EdObjectType.TREE:
                m_spriteTrees.addChild(img);
                break;
            default:
                m_spriteMain.addChild(img);
                break;
        }
    }

    public function get _id():String
    {
        return m_id;
    }

    public function deselectAll():void {

        for each (var item in m_objects)
        {
            item._states._getLine(1)._getItem(1)._image.selected = false;
            SIGNAL_SELECTED_CHANGED.dispatch(null);
        }
    }
}
}
