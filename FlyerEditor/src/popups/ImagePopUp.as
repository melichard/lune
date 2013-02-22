package popups {
import com.bit101.components.List;

import flash.display.Graphics;

import flash.display.Sprite;
import flash.events.Event;

import project.ProjectFile;

import projectContent.Image;

import starling.textures.Texture;

public class ImagePopUp {

    private var m_graphics:Sprite;
    private var m_controllingProject:ProjectFile;
    private var component:List;

    public function ImagePopUp() {
        m_graphics = new Sprite();
        component = new List(m_graphics, 0, 0, GraphicsLoader.getNames());
        component.addEventListener(Event.SELECT, onSelect);

    }

    private function onSelect(event:Event):void {
        (m_controllingProject._sheet._graphics.getChildAt(1) as Image).bdata = GraphicsLoader.getBitmapData(component.selectedItem.toString());
        (m_controllingProject._sheet._graphics.getChildAt(1) as Image)._imageID = component.selectedItem.toString();
        (m_controllingProject._sheet._graphics.getChildAt(1) as Image).selected = false;
    }

    public function get _graphics():Sprite
    {
        return m_graphics;
    }

    public function set _controllingProject(projectF:ProjectFile):void {
        m_controllingProject = projectF;
    }
}
}
