package projectContent.polygon
{
	import flash.geom.Point;

	import org.osflash.signals.ISignal;

	import org.osflash.signals.Signal;


	public class PolygonPoint
	{
		private var m_id:int;
		private var m_point:Point;
		private const SIGNAL_POINT_CHANGED:Signal = new Signal(Point);

		public function PolygonPoint(id:int, point:Point)
		{
			m_id = id;
			m_point = point;
		}

		public function get _id():int
		{
			return m_id;
		}

		public function set _id(num:int):void
		{
			m_id = num;
		}

		public function get _x():int
		{
			return m_point.x;
		}

		public function get _y():int
		{
			return m_point.y;
		}

		public function set _xy(point:Point):void
		{
			m_point.x = point.x;
			m_point.y = point.y;
			SIGNAL_POINT_CHANGED.dispatch(m_point);
		}

		public function get _signalPositionChanged():ISignal
		{
			return SIGNAL_POINT_CHANGED;
		}
	}
}
