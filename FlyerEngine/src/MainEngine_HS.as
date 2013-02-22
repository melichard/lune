/**
 * Created with IntelliJ IDEA.
 * User: Derp
 * Date: 18.6.12
 * Time: 12:43
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.media.Sound;
import flash.net.URLRequest;

import helpers.LevelProvider;
import helpers.ObjectProvider;
import helpers.OnFrame;
import helpers.SettingsMaster;
import helpers.SoundHelper;

import screen.AchievementScreen;
import screen.AchievementScreen_HS;
import screen.GameScreen_HS;
import screen.GameScreen_HS;
import screen.HighScoreScreen_HS;
import screen.MenuScreen_HS;
import screen.Screen;
import screen.Vermilion;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class MainEngine_HS extends Sprite{

    private var currentScreen:Screen;
    private var vermilion:Vermilion;
    private var menuScreen:MenuScreen_HS;
    private var gameScreen:GameScreen_HS;
    private var achievScreen:AchievementScreen_HS;
    private var highScoreScreen:HighScoreScreen_HS;

    private var ltgt:Tween;


    [Embed(source='collect_orech.mp3')]
    public var picka:Class;
    public var nutTaken1:Sound;


    private var loader:Image;

    public function MainEngine_HS() {
        this.addEventListener(Event.ADDED_TO_STAGE, initialize);
    }

    public function initialize(e:Event):void {

        LevelProvider.load();
        ObjectProvider.load();
        GraphicsLoader.start();
        SoundHelper.load();

        _initVermilion();

        currentScreen = vermilion;

        addChild(currentScreen);

        stage.addEventListener(TouchEvent.TOUCH, onclick);
        addEventListener(Event.ENTER_FRAME, _onFrame);

    }

    private function _onFrame(e:Event):void
    {
        OnFrame.frameS.dispatch();
    }

    public function onclick(e:TouchEvent):void {
        var touch:Touch = e.getTouch(stage);
        if (touch)
        {
        if (touch.phase == TouchPhase.BEGAN) {
//            addChild(currentScreen);

        }
        }
    }

    private function _vermilionToLoading(faded:Boolean):void
    {
        if (faded)
        {
        removeChild(currentScreen);
        currentScreen = menuScreen;
        }
        else
        {
        _initMenuScreen();
        addChild(menuScreen);
        swapChildren(menuScreen, currentScreen);
        }
    }

    private function _menuToGame():void
    {
        loader.x = SettingsMaster._screenWidth/2;
        loader.y = SettingsMaster._screenHeight/2;
        addChild(loader);

        if (SettingsMaster._screenWidth > 1200)
        {
            loader.scaleX = loader.scaleY = SettingsMaster._screenWidth/1200;
        }

        ltgt = new Tween(loader, 0.5);
        ltgt.onComplete = _menuToGameFadeToLoadingCompleted;
        ltgt.fadeTo(1);
        Starling.juggler.add(ltgt);
    }

    private function _menuToGameFadeToLoadingCompleted():void {

        removeChild(currentScreen);
        _initGameScreen();
        currentScreen = gameScreen;
        currentScreen.addEventListener(starling.events.Event.ADDED_TO_STAGE, _menuToGameCompleted);
        addChild(currentScreen);
    }

    private function _menuToGameCompleted(event:Event):void {
        Starling.juggler.remove(ltgt);
        removeChild(loader);
        addChild(loader);
        ltgt.reset(loader, 0.5);
        ltgt.onComplete = _loadingToGameFadedout;
        ltgt.fadeTo(0);
        Starling.juggler.add(ltgt);
    }

    private function _loadingToGameFadedout():void {
         removeChild(loader);
        Starling.juggler.remove(ltgt);
    }

    private function _menuToScore():void
    {
    }

    private function _menuToAchiev():void
    {
        removeChild(currentScreen);
        _initAchievScreen();
        currentScreen = achievScreen;
        addChild(currentScreen);
    }

    private function _gameToMenu():void
    {
        removeChild(currentScreen);
        _initMenuScreen();
        currentScreen = menuScreen;
        addChild(currentScreen);
    }

    private function _gameToGame():void
    {
        removeChild(currentScreen);
        _initGameScreen();
        currentScreen = gameScreen;
        addChild(currentScreen);
    }

    private function _achievToMenu():void
    {
        removeChild(currentScreen);
        _initMenuScreen();
        currentScreen = menuScreen;
        addChild(currentScreen);
    }

    private function _initVermilion():void
    {
        vermilion = new Vermilion();
        vermilion.nextS.add(_vermilionToLoading);
    }


    private function _initMenuScreen():void
    {
        menuScreen = new MenuScreen_HS();
        menuScreen.toGameS.add(_menuToGame);
        menuScreen.toAchievS.add(_menuToAchiev);

        loader = new Image(GraphicsLoader.loadingToGame);
        loader.alpha = 0;
        loader.pivotX = loader.width/2;
        loader.pivotY = loader.height/2;
        loader.touchable = false;
    }

    private function _initGameScreen():void
    {
        gameScreen = new GameScreen_HS();
        gameScreen.backS.add(_gameToMenu);
        gameScreen.toGameS.add(_gameToGame);

    }

    private function _initAchievScreen():void
    {
        achievScreen = new AchievementScreen_HS();
        achievScreen.backS.add(_achievToMenu);
    }

    private function _initHighScoreScreen():void
    {
        highScoreScreen = new HighScoreScreen_HS();
    }
}
}
