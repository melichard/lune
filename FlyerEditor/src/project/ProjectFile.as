package project
{
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class ProjectFile
	{
		private var m_type:String;
		private var m_workSheet:WorkSheet;
        private var m_object:EdGameObject;
        private var m_level:EdGameLevel;
        private var m_id:String;
    private var SIGNAL_CLICK:Signal = new Signal();

		public function ProjectFile(type:String, id:String)
		{
			m_workSheet = new WorkSheet(500,400);
			m_type = type;
            m_id = id;
            switch (m_type)
            {
                case ProjectTypes.OBJECT:
                        _object = new EdGameObject(id);
                    m_workSheet._width = 500;
                    m_workSheet._height = 400;
                    break;
                case ProjectTypes.LEVEL:
                    _level = new EdGameLevel(id);
                    m_workSheet._width = 960;
                    m_workSheet._height = 640;
                    break;
            }
		}


		public function get _sheet():WorkSheet
		{
			return m_workSheet;
		}

        public function set _object(gameObject:EdGameObject):void {
            m_object = gameObject;
            _sheet._clear();
            _sheet._add(gameObject._states._getLine(1)._getItem(1)._image);
            _sheet._add(gameObject._states._getLine(1)._getItem(1)._polygon);

        }

        public function get _object():EdGameObject {
            return m_object;
        }

        public function get _type():String
        {
            return m_type;
        }

        public function get _id():String
        {
            return m_id;
        }

        public function set _level(gameLevel:EdGameLevel):void {
            m_level = gameLevel;
            _sheet._clear();
            var bg:Bitmap = new Editor._levelBackground();
            bg.x = -bg.width/2;
            bg.y = -bg.height/2;
            _sheet._add(bg);
            _sheet._graphics.addEventListener(MouseEvent.CLICK, click);
            _sheet._add(m_level._graphicsDefinition);
        }

    private function click(event:MouseEvent):void {
        SIGNAL_CLICK.dispatch();
    }

    public function get _signalClicked():Signal
    {
        return SIGNAL_CLICK;
    }
        public function get _level():EdGameLevel {
            return m_level;
        }
	}
}
