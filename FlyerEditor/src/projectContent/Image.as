package projectContent {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.osflash.signals.Signal;

import project.ProjectTypes;

import tools.ToolsStatic;

import utitilites.helpers.MathHelp;

public class Image extends Sprite {
    private var m_graphics:Sprite;
    private var bmp:Bitmap;
    private var m_dragging:Boolean = false;
    private var clicked:Point;
    private var m_imageID:String;
    private var SIGNAL_MOVING:Signal = new Signal(Image);
    private var SIGNAL_CLICK:Signal = new Signal(Image);
    private var borders:Shape = new Shape();
    private var pivot:Point;


    public function Image(bitmapData:BitmapData) {
        m_graphics = this;
        pivot = new Point(bitmapData.width/2, bitmapData.height/2);
        m_graphics.addEventListener(MouseEvent.MOUSE_DOWN, o_mouseDown);
        Editor._stage.addEventListener(MouseEvent.MOUSE_UP, o_mouseUp);
        Editor._stage.addEventListener(MouseEvent.MOUSE_MOVE, o_mouseMove);
        bmp = new Bitmap(bitmapData)
        bmp.x =- pivot.x;;
        bmp.y =- pivot.y;
        addChild(bmp);
        drawBorders();
        addChild(borders);
        selected = false;
        this.mouseChildren = true;
        this.mouseEnabled = true;
    }

    public function set selected(selected:Boolean):void {
        redrawBorders();
        borders.visible = selected;
    }

    public function get selected():Boolean {
        return borders.visible;
    }

    public function get _signalMoving():Signal
    {
       return SIGNAL_MOVING;
    }
    private function o_mouseDown(event:MouseEvent):void {

        if (Editor.m_actualProject._type == ProjectTypes.OBJECT)
        {

            clicked = new Point(bmp.mouseX, bmp.mouseY);
        } else
        {

            clicked = new Point(this.parent.mouseX - this.x, this.parent.mouseY - this.y);
        }

        var pixelValue:uint = bmp.bitmapData.getPixel32(bmp.mouseX,bmp.mouseY);
        var alphaValue:uint = pixelValue >> 24 & 0xFF;

        trace( 'alphaValue: ' + alphaValue );
        trace( 'pixelValue: ' + pixelValue );

        if( alphaValue < 255 ) {
            trace( 'clicked area is not opaque' );
        } else {
            trace( 'clicked area is opaque' );
            m_dragging = true;
            SIGNAL_CLICK.dispatch(this);
        }
//        selected = true;
    }

    public function get _pivot():Point
    {
        return pivot;
    }

    public function set _pivot(point:Point):void
    {
        pivot = point;
        bmp.x =- pivot.x;
        bmp.y =- pivot.y;
    }
    public function get _signalClick():Signal
    {
        return SIGNAL_CLICK;
    }

    private function o_mouseUp(event:MouseEvent):void {
        m_dragging = false;
        clicked = null;
    }

    private function o_mouseMove(event:MouseEvent):void {
        if (m_dragging && clicked && ToolsStatic._actualTool._id == "MOVER")
        {

            if (Editor.m_actualProject._type == ProjectTypes.OBJECT)
            {
                bmp.x = this.parent.mouseX - clicked.x;
                bmp.y = this.parent.mouseY - clicked.y;
                pivot.x = -bmp.x;
                pivot.y = -bmp.y;
            }
            else
            {
                var p:Point = new Point(this.parent.mouseX - clicked.x, this.parent.mouseY- clicked.y);
                MathHelp.rotatePoint(p, new Point(0, 0), -this.parent.rotation);
                this.x = p.x;
                this.y = p.y;

            }
            SIGNAL_MOVING.dispatch(this);
        }
    }

    public function set bdata(bdata:BitmapData):void {
        bmp.bitmapData = bdata;
        pivot.x = bmp.width/2;
        pivot.y = bmp.height/2;
        bmp.x =- pivot.x;
        bmp.y =- pivot.y;
        removeChild(borders);
        drawBorders();
        addChild(borders);
    }

    public function set _imageID(id:String):void
    {
        m_imageID = id;
    }

    public function get _imageID():String
    {
        return m_imageID;
    }

    private function drawBorders():void
    {
        borders = new Shape();
//        borders.graphics.beginFill(0xFF0000);
        borders.graphics.moveTo(bmp.x, bmp.y);
        borders.graphics.lineStyle(2, 0xff0000, .75);
        borders.graphics.lineTo(bmp.x, bmp.y + bmp.height);
        borders.graphics.lineTo(bmp.x + bmp.width, bmp.y + bmp.height);
        borders.graphics.lineTo(bmp.x + bmp.width, bmp.y);
        borders.graphics.lineTo(bmp.x, bmp.y);
//        borders.graphics.endFill();
    }

    private function redrawBorders():void
    {
        borders.graphics.clear();
        borders.graphics.moveTo(bmp.x, bmp.y);
        borders.graphics.lineStyle(2, 0xff0000, .75);
        borders.graphics.lineTo(bmp.x, bmp.y + bmp.height);
        borders.graphics.lineTo(bmp.x + bmp.width, bmp.y + bmp.height);
        borders.graphics.lineTo(bmp.x + bmp.width, bmp.y);
        borders.graphics.lineTo(bmp.x, bmp.y);

    }


}
}
