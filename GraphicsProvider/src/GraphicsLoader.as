
package {

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;

import flump.display.Library;

import flump.display.LibraryLoader;
import flump.display.Movie;

import flump.executor.Future;

import starling.core.Starling;
import starling.display.Image;

import starling.events.Event;

import starling.text.BitmapFont;


import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.textures.TextureSmoothing;

public class GraphicsLoader {


    [Embed(source='../ExternalData/atlasSources/atlas_menu_gui.png')]
    private static var _gui_png:Class;
    public static var m_gui_png:Bitmap = new _gui_png();

    [Embed(source='../ExternalData/atlasSources/atlas01.png')]
    private static var _png:Class;
    public static var m_png:Bitmap = new _png();

    [Embed(source='../ExternalData/atlasSources/planets.png')]
    private static var _pngPlanet:Class;
    public static var m_pngPlanet:Bitmap = new _pngPlanet();

    [Embed(source='../ExternalData/shadow.png')]
    private static var _shadow:Class;
    public static var shadow:Texture = starling.textures.Texture.fromBitmap(new _shadow());

    [Embed(source='../ExternalData/atlasSources/atlas01.xml', mimeType="application/octet-stream")]
    private static var _xml:Class;
    [Embed(source='../ExternalData/atlasSources/planets.xml', mimeType="application/octet-stream")]
    private static var _xmlPlanet:Class;
    [Embed(source='../ExternalData/atlasSources/atlas_menu_gui.xml', mimeType="application/octet-stream")]
    private static var _xmlGui:Class;

    private static var atlas:TextureAtlas;
    private static var guiAtlas:TextureAtlas;
    private static var planetAtlas:TextureAtlas;

    private static var m_idArray:Array;
    private static var _atlas_png:Texture;
    private static var _atlas_xml:XML;
    private static var _planetAtlas_png:Texture;
    private static var _planetAtlas_xml:XML;
    private static var _guiAtlas_png:Texture;
    private static var _guiAtlas_xml:XML;
    [Embed(source='../ExternalData/background.png')]
    public static var _bg:Class;

    [Embed(source='../ExternalData/cloud.png')]
    public static var _menubg:Class;
    public static var menubg:Texture = Texture.fromBitmap(new _menubg) ;
    [Embed(source='../ExternalData/pauseBox.png')]
    private static var _pauseBox:Class;
    public static var pauseBox:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _pauseBox());

    [Embed(source='../ExternalData/exitBox.png')]
    private static var _endBox:Class;
    public static var endBox:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _endBox());

    [Embed(source='../ExternalData/exitBox2.png')]
    private static var _endBox2:Class;
    public static var endBox2:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _endBox2());


    [Embed(source='../ExternalData/pause.png')]
    private static var _pause:Class;
    public static var pause:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _pause());

    [Embed(source='../ExternalData/star.png')]
    private static var _star:Class;
    public static var star:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _star());

    [Embed(source='../ExternalData/resume.png')]
    private static var _resume:Class;
    public static var resume:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _resume());

    [Embed(source='../ExternalData/exit.png')]
    private static var _exit:Class;
    public static var exit:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _exit());

    [Embed(source='../ExternalData/playbtn.png')]
    private static var _playbtn:Class;
    public static var playbtn:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _playbtn());

    [Embed(source='../ExternalData/redo.png')]
    private static var _redo:Class;
    public static var redo:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _redo());

    [Embed(source='../ExternalData/vermilion_logo.png')]
    private static var _logo:Class;
    public static var vermilion:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _logo());

    [Embed(source='../ExternalData/cloud.png')]
    private static var _cloud:Class;
    public static var cloud:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _cloud());


    [Embed(source='../ExternalData/score.png')]
    private static var _scoreNutt:Class;
    public static var scoreNutt:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _scoreNutt());


    [Embed(source='../ExternalData/loadingtogame.png')]
    private static var _loadingToGame:Class;
    public static var loadingToGame:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _loadingToGame());
	
	[Embed(source='../ExternalData/cloud.png')]
	private static var _menuPlanet:Class;
	public static var menuPlanet:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _menuPlanet());
	[Embed(source='../ExternalData/cloud.png')]
	private static var _menuPlanetshadow:Class;
	public static var menuPlanetshadow:starling.textures.Texture = starling.textures.Texture.fromBitmap(new _menuPlanetshadow());


    [Embed(source='../ExternalData/luneTypex.xml', mimeType="application/octet-stream")]
    private static var _fontXml:Class;
    [Embed(source='../ExternalData/luneTypex.png')]
    private static var _fontPng:Class;
    [Embed(source='../ExternalData/luneTypex14.xml', mimeType="application/octet-stream")]
    private static var _font14Xml:Class;
    [Embed(source='../ExternalData/luneTypex14.png')]
    private static var _font14Png:Class;
    public static var luneFont14:BitmapFont = new BitmapFont(starling.textures.Texture.fromBitmap(new _font14Png), XML(new _font14Xml));
    public static var luneFont:BitmapFont = new BitmapFont(starling.textures.Texture.fromBitmap(new _fontPng), XML(new _fontXml));

    [Embed(source='../ExternalData/objects.zip', mimeType="application/octet-stream")]
    private static const OBJECTS_ZIP :Class;

    public static var _library:Library;

    public static function start():void
    {
      const aaa:Future = LibraryLoader.loadBytes(ByteArray(new OBJECTS_ZIP()));
        aaa.succeeded.add(onLibraryLoaded);
        aaa.failed.add(function (e :Error) :void { throw e; });


      _atlas_png = starling.textures.Texture.fromBitmap(new _png());
      _atlas_xml = XML(new _xml());

      _planetAtlas_png = Texture.fromBitmap(new _pngPlanet);
        _planetAtlas_xml = XML(new _xmlPlanet);

        _guiAtlas_png = Texture.fromBitmap(new _gui_png());
        _guiAtlas_xml = XML(new _xmlGui());

      m_idArray = new Array();
       for (var i:int=0; i<_atlas_xml.SubTexture.length(); i++) {
           m_idArray[i] = (_atlas_xml.SubTexture[i].@name);
       }
       atlas = new TextureAtlas(_atlas_png, _atlas_xml);
       planetAtlas = new TextureAtlas(_planetAtlas_png, _planetAtlas_xml);
        guiAtlas = new TextureAtlas(_guiAtlas_png, _guiAtlas_xml);

        luneFont.smoothing = TextureSmoothing.TRILINEAR;
        luneFont14.smoothing = TextureSmoothing.TRILINEAR;


    }

    private static function onLibraryLoaded(library :Library):void {
       _library = library;
    }

    public static function _getMovieFromLibrary(name:String):Movie
    {
       var movie:Movie = _library.createMovie(name);
        movie.addEventListener(Event.ADDED_TO_STAGE, function listener (e :Event) :void {
            e.target.removeEventListener(e.type, listener);
        });


        return movie;
    }

    public static function _getImageFromLibrary(name:String):Image
    {
        var image:Image = _library.createImage(name);
        image.addEventListener(Event.ADDED_TO_STAGE, function listener (e :Event) :void {
            e.target.removeEventListener(e.type, listener);
        });


        return image;
    }


    public static function getFrame(name:String):starling.textures.Texture
    {
        return atlas.getTexture(name);
    }

    public static function _getGraphicsGUI(name:String):starling.textures.Texture
    {
        return guiAtlas.getTexture(name)
    }


    public static function _getGraphicsGUIAnimations(name:String):Vector.<starling.textures.Texture>
    {
        return guiAtlas.getTextures(name)
    }

    public static function getPlanet(name:String):starling.textures.Texture
    {
        return planetAtlas.getTexture(name);
    }

    public static function getNames():Array
    {
        return m_idArray;
    }

    public static function getBitmapData(name:String):BitmapData
    {
        var _working_xml:XML;
        var _working_png:Bitmap;
        if (name == "planet_mini" || name == "planet_small" || name == "planet_medium" || name == "planet_large")
        {
            _working_xml = _planetAtlas_xml;
            _working_png = m_pngPlanet;
        }
        else {
            _working_xml = _atlas_xml;
            _working_png = m_png;
        }
        var j:int
        for (var i:int=0; i<_working_xml.SubTexture.length(); i++) {
            if (name ==_working_xml.SubTexture[i].@name)
            {
                j = i;
                var src:BitmapData = cutPoly(_working_png.bitmapData.clone(), new Rectangle(int(_working_xml.SubTexture[i].@x), int(_working_xml.SubTexture[i].@y), _working_xml.SubTexture[i].@width,_working_xml.SubTexture[i].@height));
                if ((int(_working_xml.SubTexture[j].@frameWidth) == 0) && (int(_working_xml.SubTexture[j].@frameHeight) == 0))
                {
                    return src;
                }
            }
        }
        var srcRect:Rectangle = new Rectangle(0, 0, int(_working_xml.SubTexture[j].@width), int(_working_xml.SubTexture[j].@height));
        var destPoint:Point = new Point(-int(_working_xml.SubTexture[j].@frameX), -int(_working_xml.SubTexture[j].@frameY));
        var alphaSrc:BitmapData = null;
        var alphaPoint:Point = null;
        var mergeAlpha:Boolean = true;

        var rBd:BitmapData = new BitmapData(int(_working_xml.SubTexture[j].@frameWidth), int(_working_xml.SubTexture[j].@frameHeight), true, 0x000000);
        rBd.copyPixels(src, srcRect, destPoint, alphaSrc, alphaPoint, mergeAlpha);
        return rBd;
    }

    private static function cutPoly(sourceBitmapData:BitmapData, bounds:Rectangle):BitmapData {
        // you might not need this, supplying just the sourceBitmap to finalBitmapData.draw(), it should be tested though.
//        bounds = new Rectangle(0,50,50,150);
        var bmpData:BitmapData = new BitmapData(bounds.width,bounds.height, true, 0x000000);// a new 10x10 image
        var matrixa:Matrix = new Matrix();
        matrixa.translate(-bounds.x,-bounds.y);
        var rect:Rectangle = new Rectangle(0,0,bounds.width,bounds.height);
        bmpData.draw(sourceBitmapData,matrixa,null,null,rect);

        return bmpData;
    }
}
}
