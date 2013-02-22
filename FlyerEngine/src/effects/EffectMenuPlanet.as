package effects
{
import helpers.OnFrame;

import mx.skins.halo.ScrollThumbSkin;

import org.osflash.signals.Signal;

import starling.display.Image;
import starling.display.Sprite;
import starling.extensions.pixelmask.PixelMaskDisplayObject;
import starling.textures.Texture;

public class EffectMenuPlanet extends Sprite
{
    private var t:int = 0;
    public var r:int = 0;
    public var v:Number = 0;
    public var p:int = 0;
    private var img3:Image;
    private var back:Boolean = false;
    public var _sendBack:Signal = new Signal(Boolean, EffectMenuPlanet);

    private var animation:Vector.<Texture>;
    private var planetImage:Image;

    public function EffectMenuPlanet(_v:Number,_r:int, _p:int, s:Number)
    {
        r = _r;
        v = _v;
        p = 7;
        r = Math.random()*250+300;
        v = ((2*(((r - 300)/(-250)) + 1) + 1)+0.2)/2000;
        t = Math.random()*10000;

//        var s01:Sprite = new Sprite();
        animation = GraphicsLoader._getGraphicsGUIAnimations("menu/planet/planet");
        planetImage = new Image(animation[0]);
//        s01.addChild(img);

//        var s02:Sprite = new Sprite();
//        var img2:Image = new Image(GraphicsLoader._getGraphicsGUI("menu/menu_planet"));
//        s02.addChild(img2);

//        var maskedS:PixelMaskDisplayObject = new PixelMaskDisplayObject();
//        maskedS.addChild(s01);
        var maskedS:Sprite = new Sprite();
        maskedS.addChild(planetImage);

//        maskedS.mask = s02;
        addChild(maskedS);

        img3 = new Image(GraphicsLoader._getGraphicsGUI("menu/menu_planet_shadow"))

        img3.pivotX = img3.width/2-(planetImage.width/2);
        img3.pivotY = img3.height/2-(planetImage.height/2);

//        maskedS.addChild(img3);

        maskedS.scaleX = maskedS.scaleY = s;

        OnFrame.frameS.add(_update);

    }

    private function _update():void
    {
        t++;
        this.x = Math.sin(v*t)*r;
        this.y = Math.cos(v*t)*r;

        _changeShadowPos(v*t);

        this.y = y/p;
    }

    private function _changeShadowPos(part:Number):void {
        var a:Number = part/(2*Math.PI);
        if (a > 1)
        {
            a = a % 1;
        }
        a -= 0.5;
        a *= 2;

//        img3.x = 40*a;
        planetImage.texture = animation[int((a+1)*50)];


        if (!back && a > -0.5 && a < 0.5)
        {
            back = true;
            _sendBack.dispatch(true, this);
        } else if (back && a > 0.5 && a > 0)
        {
            back = false;
            _sendBack.dispatch(false, this);
        }


    }

}
}