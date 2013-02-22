package {
import flash.geom.Point;

import projectContent.states.StatesObject;

public class EdGameObject {

    private var m_name:String = "";
    private var m_id:String = "";
    private var m_states:StatesObject = new StatesObject();
    public function EdGameObject(id:String, name:String = "obstacles.Obstacle") {
        m_id = id;
        m_name = name;
    }

    public function get _states():StatesObject
    {
        return m_states;
    }

    public function get _position():Point
    {
        return new Point(m_states._getLine(1)._getItem(1)._image.x,m_states._getLine(1)._getItem(1)._image.y);
    }
    public function get _id():String
    {
        return m_id;
    }

    public function get _name():String {
        return m_name;
    }
    public function set _name(name:String):void {
        m_name = name;
    }
}
}

