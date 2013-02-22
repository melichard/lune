/**
 * Created with IntelliJ IDEA.
 * User: Derp
 * Date: 19.7.12
 * Time: 14:22
 * To change this template use File | Settings | File Templates.
 */
package screen {
import flash.display.Bitmap;
import flash.display.Stage;
import flash.system.Capabilities;
import flash.system.System;

import helpers.OnFrame;
import helpers.SettingsMaster;

import org.osflash.signals.Signal;

import starling.display.Image;
import starling.events.Event;

public class Vermilion extends Screen{

    private var _logo:Image;
    private var _fadeCounter:int;

    private var _nextS:Signal;

    public function Vermilion() {
        super(null);

        _fadeCounter = 0;

        _nextS = new Signal();

        this.addEventListener(Event.ADDED_TO_STAGE, _onAdded);

    }

    private function _onAdded(e:Event):void
    {
        SettingsMaster.registerConsts(stage);
        _initLogo();
        OnFrame.frameS.add(_fadeIn);
    }

    private function _fadeIn():void
    {
        _fadeCounter++;
        if (_fadeCounter < 11)
            _logo.alpha += 0.1;
        if (_fadeCounter == 200)
            _nextS.dispatch(false);
        if (_fadeCounter > 200)
            _logo.alpha -= 0.05;
        if (_fadeCounter == 220)
            _nextS.dispatch(true);

     }

    private function _initLogo():void
    {
        _logo = new Image(GraphicsLoader.vermilion);
        _logo.pivotX = _logo.texture.width/2;
        _logo.pivotY = _logo.texture.height/2;
        _logo.x = stage.stageWidth/2;
        _logo.y = stage.stageHeight/2;
        _logo.alpha = 0;
        addChild(_logo);
        if (SettingsMaster._screenWidth > 1200)
        {
            _logo.scaleX = _logo.scaleY = SettingsMaster._screenWidth/_logo.width;
        }
    }

    public function get nextS():Signal
    {
        return _nextS;
    }
}
}
