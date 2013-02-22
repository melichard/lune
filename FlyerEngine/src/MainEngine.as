package {

import helpers.LevelProvider;
import helpers.ObjectProvider;
import helpers.OnFrame;

import screen.AchievementScreen;

import screen.GameScreen;
import screen.MenuScreen;
import screen.Screen;
import screen.StageScreen;
import screen.LevelScreen;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class MainEngine extends Sprite {

    private var currentScreen:Screen;
    private var gameScreen:GameScreen;
    private var menuScreen:MenuScreen;
    private var stageScreen:StageScreen;
    private var levelScreen:LevelScreen;
    private var achievementScreen:AchievementScreen;

    private var _isActive:Boolean;

    public function MainEngine() {
        _isActive = false;
        this.addEventListener(Event.ADDED_TO_STAGE, initialize);
        this.addEventListener(Event.ENTER_FRAME, onFrame);
    }

    public function initialize(e:Event):void {

        GraphicsLoader.start();
        LevelProvider.load();
        ObjectProvider.load();

        _initMenuScreen();

        currentScreen = menuScreen;

        stage.addEventListener(TouchEvent.TOUCH, onclick);

    }

    private function onFrame(e:Event):void
    {
        if (_isActive)
            OnFrame.frameS.dispatch();
    }

    private function _gameToLevel():void {
        removeChild(currentScreen);
        currentScreen = levelScreen;
        addChild(currentScreen);

    }

    private function _gameToGame(num:int):void {
        removeChild(currentScreen);
        _initGameScreen(num);
        currentScreen = gameScreen;
        addChild(currentScreen);

    }

    private function _menuToStage():void {
       removeChild(currentScreen);
       _initStageScreen();
       currentScreen = stageScreen;
       addChild(currentScreen);

    }

    private function _menuToAchiev():void {
        removeChild(currentScreen);
        _initAchievScreen();
        currentScreen = achievementScreen;
        addChild(currentScreen);

    }

    private function _stageToLevel(num:int):void {
        removeChild(currentScreen);
        _initLevelScreen(num);
        currentScreen = levelScreen;
        addChild(currentScreen);
    }

    private function _stageToMenu():void {
       removeChild(currentScreen);
       currentScreen = menuScreen;
       addChild(currentScreen);
    }

    private function _levelToStage():void {
        removeChild(currentScreen);
        _initStageScreen();
        currentScreen = stageScreen;
        addChild(currentScreen);
    }

    private function _levelToGame(levelID:int):void {
        removeChild(currentScreen);
        _initGameScreen(levelID);
        currentScreen = gameScreen;
        addChild(currentScreen);
    }

    private function _achievToMenu():void {
        removeChild(currentScreen);
        _initMenuScreen();
        currentScreen = menuScreen;
        addChild(currentScreen);
    }

    public function onclick(e:TouchEvent):void {
        var touch:Touch = e.getTouch(stage);
        if (touch.phase == TouchPhase.BEGAN) {
            addChild(currentScreen);
            _isActive = true;
        }
    }

    private function _initMenuScreen():void
    {
        menuScreen = new MenuScreen();
        menuScreen.toStageS.add(_menuToStage);
        menuScreen.toAchievS.add(_menuToAchiev);
    }

    private function _initStageScreen():void
    {
        stageScreen = new StageScreen();
        stageScreen.toLevelS.add(_stageToLevel);
        stageScreen.backS.add(_stageToMenu);
    }

    private function _initLevelScreen(num:int):void
    {
        levelScreen = new LevelScreen(num);
        levelScreen.backS.add(_levelToStage);
        levelScreen.toGameS.add(_levelToGame);

    }

    private function _initGameScreen(num:int):void
    {
        gameScreen = new GameScreen(stage, num);
        gameScreen.backS.add(_gameToLevel);
        gameScreen.toGameS.add(_gameToGame);
    }

    private function _initAchievScreen():void
    {
        achievementScreen = new AchievementScreen();
        achievementScreen.backS.add(_achievToMenu);
    }

}
}
