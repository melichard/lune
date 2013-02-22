package {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.text.TextField;

import starling.core.Starling;
import starling.events.Event;

[SWF(width="960", height="540", frameRate="60", backgroundColor="#ffffff")]
public class AirFlyerDesktop extends Sprite {


    [Embed(source='splash.png')]
    public var splash:Class;

    private var load:Bitmap;

    public function AirFlyerDesktop() {

        stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        //addChild(new Stats());
        load = new splash();
        load.x = stage.stageWidth/2 - load.width/2;
        load.y =  stage.stageHeight/2 - load.height/2 +2;
        addChild(load);

        Starling.handleLostContext = true;
        var starling:Starling = new Starling(MainEngine_HS, stage);
        starling.start();
        starling.addEventListener(Event.CONTEXT3D_CREATE, _loaded);
        starling.showStats = true;

        //addChild(new TheMiner());
    }

    private function _loaded(e:Event):void
    {
        removeChild(load);
    }
}
}
