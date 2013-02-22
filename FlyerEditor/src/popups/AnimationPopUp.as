package popups {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

import popups.timeLine.TimeLine;

import project.ProjectFile;

import projectContent.states.StateItem;

import projectContent.states.StatesObject;

public class AnimationPopUp {
    private var m_graphics:Sprite;
    private var m_controllingObject:EdGameObject;
    private var m_timeLine:TimeLine;
    private var m_controllingProject:ProjectFile;
    private var m_adding:Boolean = false;

    public function AnimationPopUp() {
        m_graphics = new Sprite();
        m_timeLine = new TimeLine();
        m_graphics.addChild(m_timeLine._graphics);
    }

    public function get _graphics():Sprite
    {
        return m_graphics;
    }

    public function set _controllingProject(projectF:ProjectFile):void
    {
        m_controllingProject = projectF;
        m_controllingObject = projectF._object;
        _makeTimeLine();
    }

    private function _makeTimeLine():void {
        m_timeLine._statesObject = m_controllingObject._states;
        m_timeLine._setActual(1,1);
        m_timeLine._onChanged.add(o_changeActualState);
        m_timeLine._signalAddItem.add(o_addItem);
    }

    private function o_addItem(state:int, frame:int):void {
        var stItem:StateItem = new StateItem();
        stItem._id = frame;
        m_controllingObject._states._getLine(state)._addItem(stItem);
        m_timeLine._statesObject =  m_controllingObject._states;
        Editor.m_popup.getChildAt(0).scaleX = (m_graphics.width + 20) / Editor.m_popup.width;
        Editor.m_popup.getChildAt(0).scaleY = (m_graphics.height + 20) / Editor.m_popup.height;

    }

    private function o_changeActualState(line:int,  item:int):void {
        m_controllingProject._sheet._clear();
        m_controllingProject._sheet._add(m_controllingObject._states._getLine(line)._getItem(item)._image);
        m_controllingProject._sheet._add(m_controllingObject._states._getLine(line)._getItem(item)._polygon);
    }
}
}
