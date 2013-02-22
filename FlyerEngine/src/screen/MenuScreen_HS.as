package screen {
import boxes.CreditsBox;

import effects.EffectMenuAll;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display3D.textures.Texture;

import gui.GuiComponent;
import gui.MenuAchievementsBar;
import gui.MenuLogoLune;
import gui.SimpleButton;
import gui.counter.GuiCounter;
import gui.notify.GuiScoreNotify;

import helpers.OnFrame;
import helpers.SettingsMaster;

import helpers.SharedSpace_HS;
import helpers.SoundHelper;

import mx.controls.dataGridClasses.DataGridLockedRowContentHolder;

import objects.Planet;

import org.osflash.signals.Signal;

import starling.animation.Juggler;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.extensions.pixelmask.PixelMaskDisplayObject;
import starling.text.TextField;
import effects.EffectMenuPlanet;

import starling.textures.Texture;

public class MenuScreen_HS extends Screen {
    private var _toGameS:Signal;
    private var _toAchievS:Signal;
    private var _toHighScoreS:Signal;

    private var _planet:Planet;
    private var _tree:Image;

    private var _creditsButton:Image;
    private var _creditsBox:CreditsBox;

    private var _achievButton:Image;

    private var _playButton:SimpleButton;

    private var _highScoreButton:Image;

    private var _logo:Image;

    private var _fadeCounter:int;

    public function MenuScreen_HS()
    {
        super();


        _toGameS = new Signal();
        _toAchievS = new Signal();
        _toHighScoreS = new Signal();

        _creditsBox = new CreditsBox();
        _creditsBox.cancelS.add(_onCancelCredits);

        SharedSpace_HS.setAchievement(1);

        this.addEventListener(Event.ADDED_TO_STAGE, _onAdded);
    }


    private var _component:GuiScoreNotify;

    private function _initHusisComponent():void {

        var backgroundAnimations:EffectMenuAll = new EffectMenuAll()
        addChild(backgroundAnimations);
        var infoButton:SimpleButton = new SimpleButton(GraphicsLoader._getGraphicsGUI("menu/menu_button_i"), GraphicsLoader._getGraphicsGUI("menu/menu_button_i_h"));
        var volumeButton:SimpleButton = new SimpleButton(GraphicsLoader._getGraphicsGUI("menu/menu_button_volume"), GraphicsLoader._getGraphicsGUI("menu/menu_button_volume_h"));

        addChild(infoButton);
        addChild(volumeButton);

        infoButton.x = 45;
        infoButton.y = 45;
        volumeButton.x = 120;
        volumeButton.y = 45;

        var achievementsBar:MenuAchievementsBar = new MenuAchievementsBar();

        achievementsBar.x = SettingsMaster._screenWidth/2;
        achievementsBar.y = (SettingsMaster._screenHeight*3)/4;

        addChild(achievementsBar);

    }

    private function _onAdded(e:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, _onAdded);

        SoundHelper.playSoundTrack();


        var background:Image = new Image(GraphicsLoader._getGraphicsGUI("menu/menubg"));
        addChild(background);
        background.pivotX = background.width/2;
        background.pivotY = background.height/2;
        background.x = SettingsMaster._screenWidth/2;
        background.y = SettingsMaster._screenHeight/2;

        if (SettingsMaster._screenWidth > 1200)
        {
             background.scaleX = background.scaleY = SettingsMaster._screenWidth/background.width;
        }

        _initCreditsButton();

        _initAchievButton();

        _initHighScoreButton();

        _initHusisComponent();
        _initPlayButton();


        _initLogo();

        OnFrame.frameS.add(_fadeIn);
    }

    private function _initLogo():void {
        var logo:MenuLogoLune = new MenuLogoLune();
        addChild(logo);
        logo._animate();
        logo.x = SettingsMaster._screenWidth/2;
        logo.y = SettingsMaster._screenHeight/2-180;
    }

    private function _fadeIn():void
    {
//        _fadeCounter++;
//        _logo.alpha += 0.1;
//        if (_logo.alpha > 1)
//            _logo.alpha = 1;
//        if (_fadeCounter < 11)
//            _logo.y++;
//
//        if (_fadeCounter > 10)
//        {
//            _playButton.alpha += 0.1;
//            if (_playButton.alpha > 1)
//                _playButton.alpha = 1;
//            if (_fadeCounter < 11)
//                _playButton.y++;
//        }
//
//        if (_fadeCounter > 20)
//        {
//            _achievButton.alpha += 0.1;
//            if (_achievButton.alpha > 1)
//                _achievButton.alpha = 1;
//            _highScoreButton.alpha += 0.1;
//            if (_highScoreButton.alpha > 1)
//                _highScoreButton.alpha = 1;
//            if (_fadeCounter < 21)
//            {
//                _achievButton.y++;
//                _highScoreButton.y++;
//            }
//        }
//        if (_playButton.alpha == 1 && _achievButton.alpha == 1 && _highScoreButton.alpha == 1)
//        {
//            OnFrame.frameS.remove(_fadeIn);
//        }
    }

    private function _toStage (e:starling.events.TouchEvent):void{
        var touch:Touch = e.getTouch(stage);
        if (touch.phase == TouchPhase.BEGAN)
        {
            _playButton.y = 305;
            _playButton.scaleX = 0.95;
            _playButton.scaleY = 0.95;
        }
        if (touch.phase == TouchPhase.ENDED)
        {
            toGameS.dispatch();
//            _component._set(1);
            _playButton.y = 300;
            _playButton.scaleX = 1;
            _playButton.scaleY = 1;
        }
    }
    private function _initPlayButton():void
    {
        _playButton = new SimpleButton(GraphicsLoader._getGraphicsGUI("menu/menu_play"), GraphicsLoader._getGraphicsGUI("menu/menu_play_h"));
        _playButton.x = stage.stageWidth/2;
        _playButton.y = stage.stageHeight/2;
        _playButton.signalClicked.add(_onPlay);
        addChild(_playButton);

    }

    private function _onPlay():void {
        toGameS.dispatch();
    }

    private function _initCreditsButton():void
    {
        _creditsButton = new Image(GraphicsLoader.pause);
        _creditsButton.alpha = 0;
        _creditsButton.x = 0;
        _creditsButton.y = 500;
        _creditsButton.addEventListener(TouchEvent.TOUCH, _onCredits);
        //addChild(_creditsButton);
    }

    private function _initHighScoreButton():void
    {
        //_highScoreButton = new Image(GraphicsLoader.getFrame("highscore_btn"));
        //_highScoreButton.alpha = 0;
        //_highScoreButton.x = 50;
        //_highScoreButton.y = 500;
        //_highScoreButton.addEventListener(TouchEvent.TOUCH, _onHighScore);
        //addChild(_highScoreButton);
    }

    private function _initAchievButton():void
    {
       // _achievButton = new Image(GraphicsLoader.getFrame("achievements_btn"));
       // _achievButton.alpha = 0;
       // _achievButton.x = 600;
       // _achievButton.y = 500;
       // _achievButton.addEventListener(TouchEvent.TOUCH, _onAchiev);
        //addChild(_achievButton);
    }

    private function _onCredits(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch)
            if (touch.phase == TouchPhase.BEGAN)
            {
                removeChild(_creditsButton);
                addChild(_creditsBox);
            }
    }

    private function _onAchiev(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch)
            if (touch.phase == TouchPhase.BEGAN)
            {
                removeChild(_achievButton);
                _toAchievS.dispatch();
            }
    }

    private function _onHighScore(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch)
            if (touch.phase == TouchPhase.BEGAN)
            {
                removeChild(_achievButton);
                _toHighScoreS.dispatch();
            }
    }

    private function _onCancelCredits():void
    {
        removeChild(_creditsBox);
        addChild(_creditsButton);
    }


    public function get toGameS():Signal
    {
        return _toGameS;
    }

    public function get toAchievS():Signal
    {
        return _toAchievS;
    }

    public function get toHighScoreS():Signal
    {
        return _toHighScoreS;
    }
}
}
