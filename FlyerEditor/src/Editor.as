package {

import flash.desktop.NativeApplication;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.NativeWindow;
import flash.display.NativeWindowInitOptions;
import flash.display.NativeWindowSystemChrome;
import flash.display.NativeWindowType;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.system.fscommand;

import helpers.LevelProvider;

import helpers.ObjectProvider;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import popups.AddObjectPopUp;

import popups.AnimationPopUp;
import popups.ImagePopUp;
import popups.LevelPopUp;
import popups.LoadPopUp;
import popups.NewPopUp;
import popups.ObjectPopUp;
import popups.SavePopUp;

import project.ProjectFile;
import project.ProjectTypes;
import project.WorkSheet;

import projectContent.Image;
import projectContent.polygon.PolygonObject;
import projectContent.states.StateItem;
import projectContent.states.StateLine;

import starling.core.Starling;
import starling.textures.Texture;

import tools.ToolsStatic;

import utitilites.GuiButton;
import utitilites.KeyboardCatcher;
import utitilites.EdLevelProvider;
import utitilites.EdObjectProvider;
import utitilites.StarlingCatcher;
import utitilites.TabsToolBar;

[SWF(width="1102", height="715", frameRate="60")]
public class Editor extends Sprite {

    [Embed("../assets/background.png")] const Background:Class;
    [Embed("../assets/tiles.png")] const BackgroundTiles:Class;
    [Embed("../assets/x.png")] public static const _xbtn:Class;
    [Embed("../assets/btn_object_properties.png")] const btn_object_properties:Class;
    [Embed("../assets/btn_object_properties_hover.png")] const btn_object_properties_hover:Class;
    [Embed("../assets/btn_planet_properties.png")] const btn_planet_properties:Class;
    [Embed("../assets/btn_planet_properties_hover.png")] const btn_planet_properties_hover:Class;
    [Embed("../assets/btn_add_object.png")] const btn_add_object:Class;
    [Embed("../assets/btn_add_object_hover.png")] const btn_add_object_hover:Class;
    [Embed("../assets/startTest.png")] const btn_start_test:Class;
    [Embed("../assets/endTest.png")] const btn_end_test:Class;
    [Embed("../assets/btn_polygon_object.png")] const btn_polygon_object:Class;
    [Embed("../assets/btn_polygon_object_hover.png")] const btn_polygon_object_hover:Class;
    [Embed("../assets/btn_animations.png")] const btn_animations:Class;
    [Embed("../assets/btn_animations_hover.png")] const btn_animations_hover:Class;
    [Embed("../assets/btn_load.png")] const btn_load:Class;
    [Embed("../assets/btn_load_hover.png")] const btn_load_hover:Class;
    [Embed("../assets/btn_save.png")] const btn_save:Class;
    [Embed("../assets/btn_save_hover.png")] const btn_save_hover:Class;
    [Embed("../assets/btn_image.png")] const btn_image:Class;
    [Embed("../assets/btn_image_hover.png")] const btn_image_hover:Class;
    [Embed("../assets/btn_new.png")] const btn_new:Class;
    [Embed("../assets/btn_new_hover.png")] const btn_new_hover:Class;
    [Embed("../assets/tool_btn.png")]
    public static const tool_btn:Class;
    [Embed("../assets/tool_btn_active.png")]
    public static const tool_btn_active:Class;
    [Embed("../assets/tool_mover.png")]
    public static const tool_mover:Class;
    [Embed("../assets/tool_polygoner.png")]
    public static const tool_polygoner:Class;
    [Embed("../assets/ico_add.png")]
    public static const _plus:Class;
    [Embed("../assets/level_bg.png")]
    public static const _levelBackground:Class;

    private var loadedContent:Signal = new Signal();
    private var m_background:Bitmap;
    private var m_openedProjects:Vector.<ProjectFile>;
    public static var m_actualProject:ProjectFile;
    private var m_actualProjectWorkSheet:WorkSheet;
    public static var _stage:Stage;
    private static const SIGNAL_UPDATE:Signal = new Signal();
    private var m_tiles:Bitmap = new BackgroundTiles();
    public static var m_shownPopup:String = "";
    public static var m_popup:Sprite;
    private var top:Sprite;
    private var bottom:Sprite;

    private var animationPopUp:AnimationPopUp;
    private var imagePopUp:ImagePopUp;
    private var projecta:Sprite;
    private var loadPopUp:LoadPopUp;
    private var savePopUp:SavePopUp;
    private var tabs:TabsToolBar;
    private var newPopUp:NewPopUp;
    private var levelPopUp:LevelPopUp;
    private var addObjectPopUp:AddObjectPopUp;
    private var objectPopUp:ObjectPopUp;
    private var m_obBtns:Vector.<GuiButton>;
    private var m_lvlBtns:Vector.<GuiButton>;
    private var bg:Bitmap;
    public function Editor() {
        var str:Starling = new Starling(StarlingCatcher, stage, new Rectangle(71, 43, 960, 640));
        bg = new Bitmap(new BitmapData(1100, 700, false, 0x555555));

        this.addChild(bg);

        str.start();
        StarlingCatcher._onAdded.add(o_init);
    }

    private function o_init():void {

        _stage = this.stage;
        _stage.addEventListener(Event.ENTER_FRAME, update);
        _stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown)
        GraphicsLoader.start();
        EdObjectProvider._load();
        EdLevelProvider._load();
        ObjectProvider.load();
        LevelProvider.load();

//        StarlingCatcher._add();
//        addChild(new Image(GraphicsLoader.getBitmapData("00")));

        ToolsStatic._initTools();
        KeyboardCatcher._start();
        initializeGUI();

        m_openedProjects = new Vector.<ProjectFile>();

        newProject(ProjectTypes.OBJECT, "default");
        a_fullFillTestProject();
        tabs._add(m_actualProject._id);

    }

    private function mouseDown(event:MouseEvent):void {
        if (stage.mouseY > 8 && stage.mouseX>1053 && stage.mouseY < 33 && stage.mouseX < 1098)
        {
            exit();
        } else if (stage.mouseY < 40) {
            (stage as Stage).nativeWindow.startMove();
        }
    }


    private function a_fullFillTestProject():void {
        var polygonObject:PolygonObject = new PolygonObject();
        polygonObject._setToDefaultObject();
        refreshPopUpControler();
    }


    private function refreshPopUpControler():void
    {
        if (m_actualProject._type == ProjectTypes.OBJECT)
        {
        animationPopUp._controllingProject = m_actualProject;
        imagePopUp._controllingProject = m_actualProject;
        objectPopUp._controllingProject = m_actualProject;
            addObjectPopUp._loadClicked.removeAll();
        } else
        {
            addObjectPopUp._loadClicked.add(m_actualProject._level._simaluteAdd);

        }

    }
    private function newProject(type:String, id:String):void {
        var projectFile:ProjectFile = new ProjectFile(type, id);
        m_openedProjects.push(projectFile);
        setActualProject(projectFile);
    }


    private function setActualProject(projectFile:ProjectFile):void {
        if (!projectFile)
        {
            projecta.visible = false;
        } else if (m_actualProject != projectFile) {
            projecta.visible = true;
            m_actualProject = projectFile;
            setWorkingSheet(projectFile._sheet);
            if (projectFile._type == ProjectTypes.OBJECT)
            {
                animationPopUp._controllingProject = projectFile;
                for each (var item:GuiButton in m_obBtns)
                {
                    item._active = true;
                }
                for each (var item:GuiButton in m_lvlBtns)
                {
                    item._active = false;
                }
            } else
            {
              for each (var item:GuiButton in m_obBtns)
              {
                  item._active = false;
              }
                for each (var item:GuiButton in m_lvlBtns)
                {
                    item._active = true;
                }
            }

            tabs._setActive(projectFile._id);
        }
    }

    private function startGame(level:EdGameLevel)
    {
        bg.visible = false;
        projecta.visible = false;
//        top.visible = false;
//        bottom.visible = false;
        StarlingCatcher._startGame(level);
    }


    private function setWorkingSheet(sheet:WorkSheet):void {
        if (m_actualProjectWorkSheet != sheet) {
            if (m_actualProjectWorkSheet) {
                projecta.removeChild(m_actualProjectWorkSheet._graphics);
                projecta.removeChild(m_tiles);
            }
            m_actualProjectWorkSheet = sheet;
            m_actualProjectWorkSheet._graphics.x = 550 - 1;
            m_actualProjectWorkSheet._graphics.y = 350 - 1;
            projecta.addChild(m_actualProjectWorkSheet._graphics);
            projecta.addChild(m_tiles)
            m_popup.visible = false;
        }
    }

    private function initializeGUI():void {
        projecta = new Sprite();
        projecta.addChild(new Bitmap(new BitmapData(5,5,false, 0xffffff)));
        projecta.x = 2;
        projecta.y = 14;
        var shape:Shape = new Shape();
        shape.graphics.beginFill(0x000000, 1);
        shape.graphics.drawRect(71, 44, 960, 640);
        shape.graphics.endFill();
        projecta.mask = shape;
        bottom = new Sprite();
        addChild(bottom);
        top = new Sprite();
        addChild(top);
        m_tiles.x = 70;
        m_tiles.y = 30;
        m_background = new Background();
        top.x = 1;
        top.y = 14;
        bottom.addChild(m_background);
        bottom.addChild(projecta);
        m_obBtns = new Vector.<GuiButton>();
        m_lvlBtns = new Vector.<GuiButton>();
        top.addChild(ToolsStatic._getToolbar());
//			bottom.addChild(m_tiles);
        var btn:GuiButton = new GuiButton(new btn_object_properties(), new btn_object_properties_hover());
        btn._signalClicked.add(btnclikckedOP);
        top.addChild(btn._graphics);
        btn._graphics.x = 1030;
        btn._graphics.y = 30 - 1;
        m_obBtns.push(btn);
        var btn2:GuiButton = new GuiButton(new btn_polygon_object(), new btn_polygon_object_hover());
        btn2._signalClicked.add(btnclikckedPO);
        top.addChild(btn2._graphics);
        btn2._graphics.x = 1030;
        btn2._graphics.y = 87 - 1;
        m_obBtns.push(btn2);
        var btn3:GuiButton = new GuiButton(new btn_animations(), new btn_animations_hover());
        btn3._signalClicked.add(btnclikckedA);
        top.addChild(btn3._graphics);
        btn3._graphics.x = 1030;
        btn3._graphics.y = 144 - 1;
        m_obBtns.push(btn3);
        var btn4:GuiButton = new GuiButton(new btn_save(), new btn_save_hover());
        btn4._signalClicked.add(btnclikckedS);
        top.addChild(btn4._graphics);
        btn4._graphics.x = 0;
        btn4._graphics.y = 144 - 1;
        var btn5:GuiButton = new GuiButton(new btn_load(), new btn_load_hover());
        btn5._signalClicked.add(btnclikckedL);
        top.addChild(btn5._graphics);
        btn5._graphics.x = 0;
        btn5._graphics.y = 87 - 1;
        var btn6:GuiButton = new GuiButton(new btn_image(), new btn_image_hover());
        btn6._signalClicked.add(btnclikckedI);
        top.addChild(btn6._graphics);
        btn6._graphics.x = 1030;
        btn6._graphics.y = 201 - 1;
        m_obBtns.push(btn6);
        var btn7:GuiButton = new GuiButton(new btn_new(), new btn_new_hover());
        btn7._signalClicked.add(btnclikckedN);
        top.addChild(btn7._graphics);
        btn7._graphics.x = 0;
        btn7._graphics.y = 30 - 1;
        var btn8:GuiButton = new GuiButton(new btn_planet_properties(), new btn_planet_properties_hover());
        btn8._signalClicked.add(btnclikckedLP);
        top.addChild(btn8._graphics);
        btn8._graphics.x = 1030;
        btn8._graphics.y = 258 - 1;
        m_lvlBtns.push(btn8);
        var btn9:GuiButton = new GuiButton(new btn_add_object(), new btn_add_object_hover());
        btn9._signalClicked.add(btnclikckedAO);
        top.addChild(btn9._graphics);
        btn9._graphics.x = 1030;
        btn9._graphics.y = 315 - 1;
        m_lvlBtns.push(btn9);
        var btn10:GuiButton = new GuiButton(new btn_start_test(), new btn_start_test());
        btn10._signalClicked.add(btnclikckedST);
        top.addChild(btn10._graphics);
        btn10._graphics.x = 10;
        btn10._graphics.y = 450 - 1;
        m_lvlBtns.push(btn10);

        m_popup = new Sprite();
        m_popup.addChild(new Bitmap(new BitmapData(200, 400, false, 0xcccccc)));
        m_popup.visible = false;
        m_shownPopup = "";

        animationPopUp = new AnimationPopUp();
        imagePopUp = new ImagePopUp();
        objectPopUp = new ObjectPopUp();
        loadPopUp = new LoadPopUp();
        loadPopUp._loadClicked.add(loadProject);

        savePopUp = new SavePopUp();
        savePopUp._signalSaveClicked.add(saveActualProject);
        top.addChild(m_popup);

        newPopUp = new NewPopUp();
        newPopUp._signalNew.add(newProjectClicked);

        levelPopUp = new LevelPopUp();

        addObjectPopUp = new AddObjectPopUp();

        tabs = new TabsToolBar();
        tabs._itemClicked.add(itemInTabsClicked);
        tabs._itemCloseClicked.add(closeProject);
        top.addChild(tabs._graphics);
        tabs._graphics.x = 150;
        tabs._graphics.y = 15;
    }


    private function closeProject(id:String):void {
        tabs._remove(id);
        var opened:Vector.<ProjectFile> = new Vector.<ProjectFile>();
        for each (var item:ProjectFile in m_openedProjects)
        {
            if (item._id != id)
            {
                opened.push(item);
            }
        }
        if (opened.length == 0)
        {
            setActualProject(null);
        } else {
            setActualProject(opened[0]);
        }
        m_openedProjects = opened;
    }

    private function newProjectClicked(type:String, id:String):void {
        tabs._add(id);
        newProject(type, id);
        m_popup.visible = false;
        m_shownPopup = "";
        refreshPopUpControler();
    }

    private function saveActualProject():void {
        if (m_actualProject._type == ProjectTypes.LEVEL)
        {

            EdLevelProvider.saveLevel(m_actualProject._level);

        }
        else
        {

            EdObjectProvider.saveObject(m_actualProject._object);
        }
        m_popup.visible = false;
        m_shownPopup = "";
    }

    private function itemInTabsClicked(id:String):void {
        for each (var item:ProjectFile in m_openedProjects) {
            if (item._id == id) {
                setActualProject(item);
            }
        }
    }

    private function loadProject(id:String, type:String = ProjectTypes.OBJECT):void {
        if (type == ProjectTypes.OBJECT) {
            var openedAlready:Boolean = false;
            for each (var item:ProjectFile in m_openedProjects)
            {
                if (item._id == id) {
                    setActualProject(item);
                    openedAlready = true;
                }
            }
            if (!openedAlready) {
            var projectFile = new ProjectFile(ProjectTypes.OBJECT, id);
            projectFile._object = EdObjectProvider.getObject(id);
            m_openedProjects.push(projectFile);
            setActualProject(projectFile);
            tabs._add(m_actualProject._id);
            }
            m_popup.visible = false;
            m_shownPopup = "";
            refreshPopUpControler();
        } else
        {
            var openedAlready:Boolean = false;
            for each (var item:ProjectFile in m_openedProjects)
            {
                if (item._id == id) {
                    setActualProject(item);
                    openedAlready = true;
                }
            }
            if (!openedAlready) {
                var projectFile = new ProjectFile(ProjectTypes.LEVEL, id);
                projectFile._level = EdLevelProvider.getLevel(id);
                m_openedProjects.push(projectFile);
                setActualProject(projectFile);
                tabs._add(m_actualProject._id);
            }
            m_popup.visible = false;
            m_shownPopup = "";
            refreshPopUpControler();

        }
    }

    private function btnclikckedN():void {
        showPopup("N");
    }


    private function update(e:Event):void {
        SIGNAL_UPDATE.dispatch();
    }


    private function btnclikckedOP():void {
        showPopup("OP");
    }


    private function btnclikckedPO():void {
        showPopup("PO");
    }


    private function btnclikckedA():void {
        showPopup("A");
    }

    private function btnclikckedS():void {
        showPopup("S");

    }

    private function exit():void
    {
        NativeApplication.nativeApplication.exit();
    }
    private function btnclikckedST():void {

        if (StarlingCatcher.playing)
        {
            StarlingCatcher._endGame();
            projecta.visible = true;
            bg.visible = true;
        } else {
            startGame(m_actualProject._level);

        }
    }

    private function btnclikckedL():void {
        showPopup("L");
    }

    private function btnclikckedLP():void {
        showPopup("LP");
    }


    private function btnclikckedAO():void {
        showPopup("AO");

    }

    private function btnclikckedI():void {
        showPopup("I");
    }


    private function showPopup(id:String):void {
        if (m_shownPopup == id) {
            m_popup.visible = false;
            m_shownPopup = "";
        } else {
            m_shownPopup = id;
            m_popup.visible = true;
            m_popup.x = 1030 - 200;
            switch (id) {
                case "OP":
                    clearPopUp();
                    m_popup.y = 30 - 1;
                    m_popup.addChild(objectPopUp._graphics);
                    m_popup.x = 1030 - objectPopUp._graphics.width - 20;
                    break;
                case "PO":
                    clearPopUp();
                    m_popup.y = 87 - 1;
                    m_popup.addChild(animationPopUp._graphics);
                    m_popup.x = 1030 - animationPopUp._graphics.width - 20;
                    break;
                case "A":

                    m_popup.y = 144 - 1;
                    clearPopUp();
                    m_popup.addChild(animationPopUp._graphics);
                    m_popup.x = 1030 - animationPopUp._graphics.width - 20;
                    break;
                case "I":
                    m_popup.y = 201 - 1;
                    clearPopUp();
                    m_popup.addChild(imagePopUp._graphics);
                    m_popup.x = 1030 - imagePopUp._graphics.width - 20;
                    break;
                case "LP":
                    m_popup.y = 158 - 1;
                    clearPopUp();
                    m_popup.addChild(levelPopUp._graphics);
                    m_popup.x = 1030 - levelPopUp._graphics.width - 20;
                    break;
                case "AO":
                    m_popup.y = 315 - 1;
                    clearPopUp();
                    m_popup.addChild(addObjectPopUp._graphics);
                    m_popup.x = 1030 - addObjectPopUp._graphics.width - 20;
                    break;
                case "S":
                    m_popup.x = 70;
                    m_popup.y = 144 - 1;
                    clearPopUp();
                    m_popup.addChild(savePopUp._graphics);
                    break;
                case "L":
                    m_popup.x = 70;
                    m_popup.y = 87 - 1;
                    clearPopUp();
                    m_popup.addChild(loadPopUp._graphics);
                    m_popup.x = 70;
                    break;
                case "N":
                    m_popup.x = 70;
                    m_popup.y = 30 - 1;
                    clearPopUp();
                    m_popup.addChild(newPopUp._graphics);
                    m_popup.getChildAt(0).scaleX = 120 / m_popup.width;
                    m_popup.getChildAt(0).scaleY = 120 / m_popup.height;
                    break;
            }
            (m_popup.getChildAt(1)).x = 10;
            (m_popup.getChildAt(1)).y = 10;
            if (id != "N")
            {
                m_popup.getChildAt(0).scaleX = (m_popup.getChildAt(1).width + 20) / m_popup.width;
                m_popup.getChildAt(0).scaleY = (m_popup.getChildAt(1).height + 20) / m_popup.height;
            }
        }
    }

    private function clearPopUp():void {

        while (m_popup.numChildren > 0) {
            m_popup.removeChild(m_popup.getChildAt(m_popup.numChildren - 1));
        }
        m_popup.addChild(new Bitmap(new BitmapData(200, 400, false, 0x333333)));
    }


    public static function get _update():ISignal {
        return SIGNAL_UPDATE;
    }
}
}
