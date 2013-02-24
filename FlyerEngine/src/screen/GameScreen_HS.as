/**
 * Created with IntelliJ IDEA.
 * User: Derp
 * Date: 18.6.12
 * Time: 13:26
 * To change this template use File | Settings | File Templates.
 */
package screen {
import flash.geom.Point;

import boxes.AchievBox;
import boxes.EndBox_HS;
import boxes.PauseBox;

import gui.counter.GuiCounter;
import gui.notify.GuiScoreNotify;

import helpers.MathHelp;
import helpers.OnFrame;
import helpers.ScoreHelper;
import helpers.SettingsMaster;
import helpers.SharedSpace_HS;
import helpers.SoundHelper;

import mx.skins.halo.TitleBackground;

import objects.GameObject;
import objects.Planet;
import objects.Squirrel;
import objects.collectables.Bird;
import objects.collectables.Collectable;
import objects.enemies.Enemy;
import objects.obstacles.Obstacle;
import objects.obstacles.Radiol;

import org.osflash.signals.Signal;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.display.Stage;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.utils.Color;

public class GameScreen_HS extends Screen{

    protected var gObjects:Vector.<GameObject>;

    protected var content:Sprite;
    protected var game:starling.display.Sprite;

    private var squirrel:Squirrel;
    private var planet:Planet;

    private var _toGameS:Signal

    private var center:Point;

    private var pause:Image;

    public var pauseBox:PauseBox;
    private var endBox:EndBox_HS;
    private var achievBox:AchievBox;

    private var _isAchievShowed:Boolean;
    private var _achievQueue:Vector.<AchievBox>;

    private var _nextTree:Number;
    private var _nextNut:Number;
    private var _nextCloud:Number;

    private var _isTreeGenerated:Boolean;
    private var _isNutGenerated:Boolean;
    private var _isCloudGenerated:Boolean;

    private var _prevRotation:Number;
    private var _maxRotation:Number;

    private var _score:int;
    private var _scoreText:TextField;

    private var _time:int;
    private var _timeText:TextField;

    private var _redCounter:int;
    private var _greenCounter:int;
    private var _yellCounter:int;

    private var _backgroundObjects:Sprite;
    private var _component:GuiCounter;

    private var _lastDistance:Number;

    private var _startCam:int;

    private var effects:Sprite;

    private var _isMagnet:Boolean;

    private var _upperPace:Point;
	
	private var _obstacles:Vector.<Obstacle>;
	private var _obstaclesN:int;
	private var _collectables:Vector.<Collectable>;
	private var _collectablesN:int;
    private var _bgClouds:Sprite;
    private var _bgHills:Sprite;
    private var _bgTrees:Sprite;
    private var _isBgTreeGenerated:Boolean;
    private var _nextBgTree:Number;

    public function GameScreen_HS()
    {
        super(new GraphicsLoader._bg());

        _time = 900;
        _score = 0;
        _nextTree = 0;
        _nextNut = 0;
        _lastDistance = 0;
        _maxRotation = 0;
        _redCounter = 0;
        _greenCounter = 0;
        _yellCounter = 0;
        _startCam = 0;
        _upperPace = new Point();
		_obstaclesN = 0;
		_collectablesN = 0;

        _isTreeGenerated = false;
        _isNutGenerated = false;
        _isCloudGenerated = false;

        _isMagnet = false;

        _toGameS = new Signal();

        addEventListener(Event.ADDED_TO_STAGE, _onAdded);
    }

    private function _onAdded(e:starling.events.Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, _onAdded);
        _initContent();

        planet = new Planet(480);
        planet.x = stage.stageWidth/2;
        planet.y = stage.stageHeight - 90 + planet.radius;

        center = new Point(stage.stageWidth/2,stage.stageHeight - 90 + planet.radius);

        _initBackground();

        _initBackgroundObjects();

        _initGame();
		
		_initVectors();

        game.addChildAt(planet, 0);

        _initPauseButton();

        _initGObjects();

        _initPauseBox();

        _initEndBox();

        _initScoreText();

        _initTimeText();

        _isAchievShowed = false;
        _achievQueue = new Vector.<AchievBox>();

        squirrel = new Squirrel();
        game.addChild(squirrel);

        effects = new Sprite();
        game.addChild(effects);
        /*for (var i:int = 0; i < 9 ; i++)
         {
         game.addChild(squirrel.parts[i].polygon);
         }*/



    }

    protected override function _onFrame():void
    {
        super._onFrame();
		game.flatten();

        _detectCollision();

        _rotateGame();

        _generateTree();

        _generateNut();

        _generateBackground();

        _removePassed();

        _dynamicCamera();

        _gravityField();

        _time--;
        _component._set(_time);
        if (_time == 0)
        {
            addChild(endBox);
        }

    }

    private function _detectCollision():void
    {
        OnFrame.bla = 0;
		var position:Point = new Point();
		var type:String;
		var globalPositionX:Number;
        for (var i:int = 0; i < gObjects.length; i++)
        {
			position = gObjects[i].position;
			globalPositionX = game.localToGlobal(position).x;
            if (globalPositionX < center.x + 120 && globalPositionX > center.x - 120)
            {
                if (gObjects[i] is Collectable && _isMagnet)
                {
                    if (Point.distance(squirrel.parts[1].position,  gObjects[i].position ) < 100)
                    {
                        gObjects[i].x += (squirrel.parts[3].x - gObjects[i].x)/8;
                        gObjects[i].y += (squirrel.parts[3].y - gObjects[i].y)/8;
                    }
                }
                for (var j:int = 0; j < 9; j++)
                {
                    if (squirrel.parts[j].getBounds(game).intersects(gObjects[i].getBounds(game)))
                    {

                        if (squirrel.collides(gObjects[i].polygon) && gObjects[i]._firstHit)
                        {
                            gObjects[i].onHit();

                            if (gObjects[i] is Obstacle)
                            {
                                var animation:GuiScoreNotify = new GuiScoreNotify(-100);

//                    animation._signalCompleted.add(_collectedAnimationEnd);
                                game.addChild(animation);
                                ScoreHelper._plus(-100);
                                SoundHelper.playSound("hit");
                                var point:Point = game.localToGlobal(squirrel.parts[0].position);
                                var point2:Point = game.globalToLocal(point);
                                animation.x = point2.x;
                                animation.y = point2.y - 30;
                                animation.rotate(center);
                                animation._animate();
                            }

                            if (gObjects[i] is Collectable)
                            {
                                animation = new GuiScoreNotify(gObjects[i].score);

//                    animation._signalCompleted.add(_collectedAnimationEnd);
                                game.addChild(animation);
                                ScoreHelper._plus(gObjects[i].score);
                                point = game.localToGlobal(squirrel.parts[0].position);
                                point2 = game.globalToLocal(point);
                                animation.x = point2.x;
                                animation.y = point2.y - 30;
                                animation.rotate(center);
                                animation._animate();
								type = gObjects[i].getId;

                                if (type == "boostr")
                                    OnFrame.frameS.add(_speedUp);
                                else if (type == "boostg")
                                    OnFrame.frameS.add(_switchControls);
                                else if (type == "boosty")
                                    OnFrame.frameS.add(_magnet);
								_time += 120;
								_component._set(_time);
                            }

                        }
                    }
                    break;
                }

            }
        }

       /* if (squirrel.hitGround())
        {
            _end();
        }    */


        var current:GameObject;
        for (i = 0; i < gObjects.length; i++)
        {
            if (gObjects[i].isHit)
            {
                if (gObjects[i] is Collectable)
                {		
					game.removeChild(gObjects[i]);			
					_collectables[29] = _collectables[_collectables.indexOf(gObjects[i])];
					for (var k:int = _collectables.indexOf(gObjects[i]) + 1; k < 30; k++)
					{
						_collectables[k - 1] = _collectables[k];	
					}
					_collectablesN--;
					var len:int = gObjects.length - 1;
					gObjects[i] = gObjects[len];
					gObjects.length = len;			
                }
            }
        }

    }

    private function _magnet():void
    {
        if (_yellCounter == 0)
            _isMagnet = true;
        if (_yellCounter == 600)
        {
            OnFrame.frameS.remove(_magnet);
            _yellCounter = 0;
            _isMagnet = false;
            return;
        }
        _yellCounter++;
    }

    private function _speedUp():void
    {
        if (_redCounter < 3)
        {
            squirrel.setSpeed((squirrel.speed) + 1);
        } else if (_redCounter > 596 && _redCounter < 600)
        {
            squirrel.setSpeed((squirrel.speed) - 1);
        } else if (_redCounter == 600)
        {
            OnFrame.frameS.remove(_speedUp);
            _redCounter = 0;
            return;
        }
        _redCounter++;
    }

    private function _switchControls():void
    {
        if (_greenCounter == 0)
        {
            squirrel.switchControls();
        } else if (_greenCounter == 600)
        {
            OnFrame.frameS.remove(_switchControls);
            _greenCounter = 0;
            squirrel.switchControls();
            return;
        }

        _greenCounter++;
    }

    private function _end():void
    {
        SharedSpace_HS.setScore(1, _score);
        addChild(endBox);

    }

    private function _dynamicCamera():void
    {
        var pivot:Number = 150 +  (center.y - (Point.distance(new Point(squirrel.parts[4].x, squirrel.parts[4].y), center))) /2;
//        if (content.pivotY < pivot)
//        {
//            _startCam++;
//            content.pivotY++;
//        } else
            content.pivotY = pivot;

    }


    private function _generateTree():void
    {
        if (_isTreeGenerated)
        {
          if (_nextTree > game.rotation || (_nextTree < -Math.PI && game.rotation > 0 && _nextTree + Math.PI*2 > game.rotation))
          {
              _isTreeGenerated = false;
              _createObstacle();
          }
        }
        else
        {
            var _next:Number = Math.random()*Math.PI/4 + Math.PI/4;
            _isTreeGenerated = true;
            _nextTree = game.rotation - _next;
        }
    }

    private function _generateNut():void
    {
        if (_isNutGenerated)
        {
            if (_nextNut > game.rotation || (_nextNut < -Math.PI && game.rotation > 0 && _nextNut + Math.PI*2 > game.rotation))
            {
                _isNutGenerated = false;
                _createNut();
            }
        }
        else
        {
            var _next:Number = Math.random()*Math.PI/24 + Math.PI/32;
            _isNutGenerated = true;
            _nextNut = game.rotation - _next;
        }
    }

    private function _removePassed():void
    {
        for (var i:int = 0; i < gObjects.length; i++)
        {
            var objectPosition:Point = game.localToGlobal(gObjects[i].position);
            if (objectPosition.x < center.x && objectPosition.y > 600 + content.pivotY)
			{
				if (gObjects[i] is Obstacle)
				{
					game.removeChild(gObjects[i]);
					_obstacles[14] = _obstacles[_obstacles.indexOf(gObjects[i])];
					for (var k:int = _obstacles.indexOf(gObjects[i]) + 1; k < 15; k++)
					{
						_obstacles[k - 1] = _obstacles[k];	
					}
					_obstaclesN--;	
					var len:int = gObjects.length - 1;
					gObjects[i] = gObjects[len];
					gObjects.length = len;					
				}
				
				if (gObjects[i] is Collectable)
				{
					game.removeChild(gObjects[i]);
					_collectables[29] = _collectables[_collectables.indexOf(gObjects[i])];
					for (k = _collectables.indexOf(gObjects[i]) + 1; k < 30; k++)
					{
						_collectables[k - 1] = _collectables[k];	
					}
					_collectablesN--;	
					len = gObjects.length - 1;
					gObjects[i] = gObjects[len];
					gObjects.length = len;					
				}
            }
        }
    }

    private function _createObstacle():void
    {
        var random:int = Math.floor(Math.random()*4);
        var object:GameObject = _obstacles[_obstaclesN];
		_obstaclesN++;
        var object2:GameObject;
        var object3:GameObject;
        var objectPosition:Point = game.globalToLocal(new Point(center.x + planet.radius, center.y + 250 - content.pivotY));
        switch (random)
        {
            case 0:
                object.changeType("tree01f");
				object.x = objectPosition.x;
				object.y = objectPosition.y;
                break;
            case 1:
				object.changeType("tree02a");
				object.x = objectPosition.x;
				object.y = objectPosition.y;
                break;
            case 2:
				object.changeType("tree03a");
				object.x = objectPosition.x;
				object.y = objectPosition.y;
                break;
            case 3:
				object.changeType("tree01f");
				object.x = objectPosition.x;
				object.y = objectPosition.y;
                break;
        }
        object.rotate(center);
		object._firstHit = true;
		object.isHit = false;
        gObjects.push(object);
        game.addChildAt(object, game.getChildIndex(squirrel));

		/*for (var i:int = 0; i < 9 ; i++)
		{
			game.setChildIndex(squirrel.parts[i].polygon, game.getChildIndex(squirrel));
		}*/
    }

    private function _createNut():void
    {
        var objectPosition:Point = game.globalToLocal(new Point(center.x + planet.radius + Math.random()*400, center.y + 250 - content.pivotY));

        var type:String = "nutt0";
        var random:int = (Math.floor(Math.random()*101));
        if (random > 50)
            type = "nutt1";
        if (random > 75)
            type = "nutt2";
        if (random > 85)
        {
            var random2:int = (Math.floor(Math.random()*4));
            if (random2 == 0)
                type = "boostr";
            else if (random2 == 1)
                type = "boosty";
            else if (random2 == 2)
                type = "boostg";
            else if (random2 == 3)
                type = "boostb";
            type = "boosty";
        }
        if (random > 95)
            type = "nutt3";
        var object:GameObject = _collectables[_collectablesN];
		object.changeType(type);
		_collectablesN++;
		object._firstHit = true;
		object.isHit = false;

        if (random<20)
        {
            object = new Bird(objectPosition);
        }
        var random3:int = Math.floor(Math.random()*10);

        if (random3 > 7)
        {
            object = new Radiol(objectPosition);
        }
        object.x = objectPosition.x;
        object.y = objectPosition.y;
        object.rotate(center);

        gObjects.push(object);
        game.addChild(object);

		//game.addChild(object.polygon);

    }

    private function _generateBackground():void
    {
        if (_isCloudGenerated)
        {
            if (_nextCloud > game.rotation || (_nextCloud < -Math.PI && game.rotation > 0 && _nextCloud + Math.PI*2 > game.rotation))
            {
                _isCloudGenerated = false;
                var objectPosition:Point = _bgClouds.globalToLocal(new Point(Math.random()*200 + center.x + planet.radius + 250, center.y + 250 - content.pivotY));
                var image:Image = new Image(GraphicsLoader.getFrame("cloud"));
                image.x = objectPosition.x;
                image.y = objectPosition.y;
                image.pivotX = image.width/2;
                image.pivotY = image.height/2;
                image.rotation = MathHelp.angle(center.x - image.x, center.y - image.y) - Math.PI;
                _bgClouds.addChild(image);
            }
            _bgClouds.flatten();
        }
        else
        {
            var _next:Number = Math.random()*Math.PI/5 + Math.PI/5;
            _isCloudGenerated = true;
            _nextCloud = game.rotation - _next;
        }

        if (_isBgTreeGenerated)
        {
            if (_nextBgTree > game.rotation || (_nextBgTree < -Math.PI && game.rotation > 0 && _nextBgTree + Math.PI*2 > game.rotation))
            {
                _isBgTreeGenerated = false;
                var objectPosition:Point = _bgTrees.globalToLocal(new Point(center.x + planet.radius+150, center.y + 250 - content.pivotY));
                var image:Image = new Image(GraphicsLoader.getFrame("trees/front/tree_01b"));
                image.x = objectPosition.x;
                image.y = objectPosition.y;
                image.pivotX = image.width/2;
                image.pivotY = image.height/2;
                image.rotation = MathHelp.angle(center.x - image.x, center.y - image.y) - Math.PI;
                _bgTrees.addChild(image);

            }
            _bgTrees.flatten();
        }
        else
        {
            var _next:Number = Math.random()*Math.PI/5 + Math.PI/5;
            _isBgTreeGenerated = true;
            _nextBgTree = game.rotation - _next;
        }
    }

    private function _gravityField():void
    {
        var distance:Number = Point.distance(squirrel.parts[0].position, center);
        if (distance >= 1000)
        {
            var vel:Point = new Point(center.x - squirrel.parts[0].x,  center.y - squirrel.parts[0].y);
            var rot:Number = MathHelp.angle(vel.x,  vel.y);
            var vel2:Point = MathHelp.vectorFromRad(rot, 0.1)
            if (_lastDistance < 1000)
            {
               if (game.localToGlobal(squirrel.parts[0].position).x > game.localToGlobal(squirrel.parts[1].position).x)
                   squirrel.turningRight = true;
               else
                   squirrel.turningLeft = true;
            }

        } else if (distance < 1000 && _lastDistance >= 1000)
        {
                squirrel.turningLeft = false;
                squirrel.turningRight = false;
        }
        _lastDistance = distance;
    }

    private function _initBackground():void
    {
          background.pivotX = background.width/2;
          background.pivotY = background.height/2;
        background.x = SettingsMaster._screenWidth/2;
        background.y = SettingsMaster._screenHeight/2;

        if (SettingsMaster._screenWidth > 1200)
        {
            background.scaleX = background.scaleY = SettingsMaster._screenWidth/1200;
        }
//        removeChild(background);
//        background.pivotX = background.width/2;
//        background.pivotY = background.height/2;
//        background.x = center.x;
//        background.y = center.y;
//        background.scaleX = 1.2;
//        background.scaleY = 1.2;
//        background.touchable = false;
    }

    private function _initContent():void
    {
        content = new Sprite();
        content.width = stage.stageWidth;
        content.height = stage.stageHeight;
        content.pivotX = stage.stageWidth/2;
        content.pivotY = 0;
        content.x = stage.stageWidth/2;
        content.y = 250;
        addChild(content);
    }
	
	private function _initVectors():void
	{
		_obstacles = new Vector.<Obstacle>();
		_collectables = new Vector.<Collectable>();
		for (var i:int = 0; i < 15; i++)
		{
			_obstacles.push(new Obstacle(null));
		}
		for (var i:int = 0; i < 30; i++)
		{
			_collectables.push(new Collectable(null));
		}
	}

    private function _initGame():void
    {
        game = new Sprite();
        game.pivotX = center.x;
        game.pivotY = center.y;
        game.x = center.x ;
        game.y = center.y ;
        content.addChildAt(game, 1);
    }

    private function _initGObjects():void
    {
        gObjects = new Vector.<GameObject>();
        for each (var object:GameObject in gObjects)
        {
            game.addChild(object);
            object.rotate(center);
        }
    }


    private function _initPauseButton():void
    {
        pause = new Image(GraphicsLoader.pause);
//        pause.addEventListener(starling.events.TouchEvent.TOUCH, _onPauseButton);
        addChild(pause);
        pause.x = -20;
        pause.y = -20;
    }

    private function _initPauseBox():void
    {
        pauseBox = new PauseBox();
        pauseBox.resumeS.add(_onResume);
        pauseBox.exitS.add(_onExit);
        pauseBox.pauseS.add(_onPause);
        pauseBox.redoS.add(_onRedo);
    }

    private function _initEndBox():void
    {
        endBox = new EndBox_HS();
        endBox.exitS.add(_onExit);
        endBox.redoS.add(_onRedo);
        endBox.pauseS.add(_onPause);
    }



    private function _initScoreText():void
    {
        ScoreHelper._initGuiScore();
        addChild(ScoreHelper._guiScore);
    }

    private function _initTimeText():void
    {
        _component = new GuiCounter();
        addChild(_component);
        _component._startTime = _time;
        _component.x = stage.stageWidth/2;
        _component.y = 30;
    }

    private function _initBackgroundObjects():void
    {
        _backgroundObjects = new Sprite();
        content.addChild(_backgroundObjects);
        _backgroundObjects.touchable = false;
        _bgClouds = new Sprite();
        _bgClouds.pivotX = center.x;
        _bgClouds.pivotY = center.y
        _bgClouds.x = center.x;
        _bgClouds.y = center.y;
        _bgClouds.touchable = false;
        _bgHills = new Sprite()
        _bgHills.pivotX = center.x;
        _bgHills.pivotY = center.y
        _bgHills.x = center.x;
        _bgHills.y = center.y;
        _bgHills.touchable = false;
        _bgTrees = new Sprite();
        _bgTrees.pivotX = center.x;
        _bgTrees.pivotY = center.y
        _bgTrees.x = center.x;
        _bgTrees.y = center.y;
        _bgTrees.touchable = false;
        _backgroundObjects.addChild(_bgClouds);
        _backgroundObjects.addChild(_bgHills);
        _backgroundObjects.addChild(_bgTrees);
    }

    private function _showAchievBox(id:int):void
    {
        if (_isAchievShowed)
        {
            _achievQueue.push(new AchievBox(id));
        } else
        {
            addChild(_achievQueue.pop());
            _isAchievShowed = true;
        }
    }

    private function _rotateGame():void
    {
        var vector1:Point = new Point (squirrel.position.x - center.x,  squirrel.position.y - center.y);
        var vector2:Point = new Point (0, -400);
        var scalarSum:Number = vector1.x*vector2.x + vector1.y*vector2.y;
        var vectorSum:Number = Math.sqrt(vector1.x*vector1.x + vector1.y*vector1.y)* Math.sqrt(vector2.x*vector2.x + vector2.y*vector2.y);
        _prevRotation = game.rotation;
        game.rotation = -Math.acos(scalarSum / vectorSum);
        if (squirrel.position.x < center.x)
            game.rotation = -game.rotation;
        var rot:Number = game.rotation - _prevRotation;
        if (rot > Math.PI/2 || rot < -Math.PI/2)
        {
            rot = (2*Math.PI - Math.abs(game.rotation) - Math.abs(_prevRotation)) * _prevRotation/Math.abs(_prevRotation);
        }
//        background.rotation += (rot)/3;
        _bgClouds.rotation += (rot)/2;
        _bgTrees.rotation += (rot)/1.1;

        if (game.rotation - _maxRotation > Math.PI)
            _maxRotation += Math.PI*2;

        if (game.rotation <= _maxRotation)
        {
            ScoreHelper._plus(1);
            _maxRotation = game.rotation - Math.PI/20;
        }
    }

    private function _onPauseButton(e:starling.events.TouchEvent):void
    {
        var touch:Touch = e.getTouch(stage);
        if (touch.phase == TouchPhase.BEGAN)
        {
            addChild(pauseBox);
        }
    }

    private function _onResume():void
    {
        removeChild(pauseBox);
        OnFrame.frameS.add(_onFrame);
        squirrel.resume();
        addChild(pause);
    }

    private function _onPause():void
    {
        removeChild(pause);
        OnFrame.frameS.remove(_onFrame);
        squirrel.pause();
    }

    private function _onExit():void
    {
        _backS.dispatch();
    }

    private function _onRedo():void
    {
        _toGameS.dispatch();
    }

    public function get toGameS():Signal
    {
        return _toGameS;
    }





}
}
