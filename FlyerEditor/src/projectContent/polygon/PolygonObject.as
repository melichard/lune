package projectContent.polygon
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import projectContent.polygon.PolygonObject;
	import projectContent.polygon.PolygonPoint;

import tools.ToolsStatic;

import utitilites.KeyboardCatcher;
import utitilites.helpers.MathHelp;
import utitilites.helpers.MathHelp;
import utitilites.helpers.MathHelp;


public class PolygonObject extends Sprite
	{

		private var m_graphics:Sprite;
		private var m_polygonPoints:Vector.<PolygonPoint>;
		private var m_polygonGraphics:Array;
		private var m_draggingTarget:Sprite;
		private var m_draggingTargetId:int = 0;
		private var m_draggingTargetPoint:PolygonPoint;
		private var m_adding:Boolean = false;
		private var m_addingPoint:PolygonPoint;
		private var m_addorremove:Boolean = false;

		public function PolygonObject()
		{
			m_graphics = this;
			Editor._update.add(update);
            ToolsStatic._signalToolChanged.add(checkToolChanged);
            m_polygonPoints = new Vector.<PolygonPoint>();
		}

        private function checkToolChanged():void {
            if (ToolsStatic._actualTool._id == "POLYGONER")
            {
                m_graphics.visible = true;
            }
            else
            {
                m_graphics.visible = false;

            }
        }

        public function get _points():Vector.<PolygonPoint>
        {
            return m_polygonPoints;
        }

		private function update():void
		{
			if (KeyboardCatcher._isKeyPressed("16"))
			{
				if (!m_adding)
				{
					m_adding = true;
				}

				o_checkForNewPoint();
			} else if (m_adding)
			{
				m_adding = false;
				if (!m_addorremove) {
					_remove(m_addingPoint);
					m_draggingTarget = null;
					m_draggingTargetId = 0;
					m_draggingTargetPoint = null;
				}
				m_addingPoint = null;
			}
		}


		private function o_checkForNewPoint():void
		{
			if (!m_addingPoint)
			{
				var posPoint:Point = new Point(m_graphics.mouseX, m_graphics.mouseY);
				var newId:int = o_getIdFromNearest(posPoint);
				m_addingPoint = new PolygonPoint(newId, posPoint);
				_add(m_addingPoint);
				m_draggingTarget = m_polygonGraphics[newId-1];
				m_draggingTargetId = newId
				m_draggingTargetPoint = m_addingPoint;
				m_draggingTarget.alpha = 0.5;
			}
		}


		private function o_getIdFromNearest(point:Point):int
		{
			var nearest:PolygonPoint;
			var nearestValue:Number;
			for each(var item:PolygonPoint in m_polygonPoints)
			{
				if (!nearest)
				{
					nearest = item;
					nearestValue = math_getDistance(point, new Point(item._x,  item._y));
				} else if (nearestValue > math_getDistance(point, new Point(item._x,  item._y)))
				{
					nearestValue = math_getDistance(point, new Point(item._x,  item._y));
					nearest = item;
				}
			}
            var bodA:PolygonPoint;
            var bodC:PolygonPoint;
            if (nearest._id != 1 && nearest._id != m_polygonPoints.length)
            {
            bodA = getPointByID(nearest._id-1);
            bodC = getPointByID(nearest._id+1);

            }
            else if (nearest._id == 1)
            {
                bodA = getPointByID(m_polygonPoints.length);
                bodC = getPointByID(nearest._id+1);
            }
            else if (nearest._id == m_polygonPoints.length)
            {
                bodA = getPointByID(nearest._id - 1);
                bodC = getPointByID(1);
            }

            var line = MathHelp.osUhlaTrochBodov(
                            new Point(bodA._x,  bodA._y),
                            new Point(nearest._x, nearest._y),
                            new Point(bodC._x,  bodC._y));
            trace(nearest._id,  line.x, line.y);
            if (!MathHelp.bodyRovnakejPolroviny(point, new Point(bodA._x,  bodA._y), MathHelp.koeficientyPriamkyZBodov(new Point(nearest._x,  nearest._y),new Point(nearest._x + line.x , nearest._y + line.y))))
            {
                if (nearest._id != m_polygonPoints.length)
                {
                nearest =  getPointByID(nearest._id + 1);
                }
                else
                {
                    nearest = getPointByID(1);
                }
            }
            return nearest._id;
		}

        private function getPointByID(id:int):PolygonPoint
        {
            for each(var item:PolygonPoint in m_polygonPoints)
            {
                if (item._id == id)
                {
                    return item;
                }
            }
            return null;
        }

		private function math_getDistance(point1:Point,  point2:Point):Number
		{
			var r:Number = Math.sqrt((point1.y - point2.y)*(point1.y - point2.y) + (point1.x - point2.x)*(point1.x - point2.x));
			return r;
		}

		public function _setToDefaultObject():void
		{
			_add(new PolygonPoint(1, new Point(-10,-10)));
			_add(new PolygonPoint(2, new Point(-10,10)));
			_add(new PolygonPoint(3, new Point(10,10)));
			_add(new PolygonPoint(4, new Point(10,-10)));
		}


		public function _add(polygonPoint:PolygonPoint):void
		{
			m_polygonPoints.push(polygonPoint);
			for each (var item:PolygonPoint in m_polygonPoints)
			{
				if ((item._id >= polygonPoint._id) && (polygonPoint != item))
				{
					item._id += 1;
				}
			}
			refillGraphics();
		}


		private function _remove(polygonPoint:PolygonPoint):void
		{
			var polygonPoints:Vector.<PolygonPoint> = new Vector.<PolygonPoint>();
			for each (var item:PolygonPoint in m_polygonPoints)
			{
				if (item._id > polygonPoint._id)
				{
					item._id -= 1;
				}
			 	if (item != polygonPoint)
				 {
					polygonPoints.push(item);
				 }
			}
			m_polygonPoints = new Vector.<PolygonPoint>();
			m_polygonPoints = polygonPoints;
			refillGraphics();
		}

		private function clearGraphics():void
		{


			while(m_graphics.numChildren > 0)
			{
				m_graphics.removeChild(m_graphics.getChildAt(m_graphics.numChildren-1));
			}


		}

		private function redrawObject():void
		{
			for (var i:int=0; i<m_polygonGraphics.length; i++)
			{
				addChild(m_polygonGraphics[i]);
				if (i > 0)
				{
					var line:Sprite = lineFromTo(m_polygonGraphics[i-1], m_polygonGraphics[i]);
					var lineDot:Bitmap = new Bitmap(new BitmapData(1,1,false,0xff0000));
					lineDot.x = line.x;
					lineDot.y = line.y;
					addChild(line);
				}
				if (i == 0)
				{
					var line:Sprite = lineFromTo(m_polygonGraphics[m_polygonGraphics.length-1], m_polygonGraphics[0]);

					var lineDot:Bitmap = new Bitmap(new BitmapData(1,1,false,0xff0000));
					lineDot.x = line.x;
					lineDot.y = line.y;
					addChild(line);

				}
			}

		}


		private function lineFromTo(m_polygonGraphic:Sprite, m_polygonGraphic2:Sprite):Sprite
		{
			var line:Bitmap = new Bitmap(new BitmapData(1,1, false, 0xff33ff));
			var startPoint:Point = new Point(m_polygonGraphic.x,m_polygonGraphic.y);
			var endPoint:Point = new Point(m_polygonGraphic2.x,m_polygonGraphic2.y);
			line.scaleX = Math.sqrt((startPoint.y - endPoint.y)*(startPoint.y - endPoint.y) + (startPoint.x - endPoint.x)*(startPoint.x - endPoint.x));

			var angleInRadians:Number;
			var distanceX:Number = endPoint.x - startPoint.x;
			var distanceY:Number  = endPoint.y - startPoint.y;
			//			trace(distanceX + " " + distanceY);
			angleInRadians = Math.atan2(distanceY, distanceX);
            var spr:Sprite = new Sprite();
            spr.x = startPoint.x;
            spr.y = startPoint.y;
			line.rotation = angleInRadians *180  / Math.PI;
            spr.addChild(line);
			return spr;
		}

		private function refillGraphics():void
		{
			clearGraphics();
			m_polygonGraphics = new Array(m_polygonPoints.length);

			for each (var item:PolygonPoint in m_polygonPoints)
			{
				var pointGraphics:Sprite = new Sprite();
				var pointBmp:Bitmap = new Bitmap((new BitmapData(5,5, false, 0xff00ff)));
				var pointBmps:Bitmap = new Bitmap((new BitmapData(1,1, false, 0x000000)));
				pointBmp.alpha = 1;
				pointBmp.x = -2;
				pointBmp.y = -2;
				pointBmps.x = 2;
				pointBmps.y = 2;
				pointGraphics.addChild(pointBmp);
				pointGraphics.addChild(pointBmps);
				pointGraphics.x = item._x;
				pointGraphics.y = item._y;
//				pointGraphics.alpha = 0.3;
				Editor._stage.addEventListener(MouseEvent.MOUSE_UP, pointMouseUp);
				pointGraphics.addEventListener(MouseEvent.MOUSE_DOWN, pointMouseDown);
				pointGraphics.addEventListener(MouseEvent.ROLL_OVER, pointMouseOver);
				Editor._stage.addEventListener(MouseEvent.MOUSE_MOVE, pointMouseMove);
				pointGraphics.buttonMode = true;
				m_polygonGraphics[item._id-1] = pointGraphics;
			}
			redrawObject();
		}


		private function pointMouseMove(e:MouseEvent):void
		{
		 	if (m_draggingTarget)
			 {
				 m_draggingTargetPoint._xy = new Point(m_graphics.mouseX, m_graphics.mouseY);
				 m_draggingTarget.x = m_graphics.mouseX - 1;
				 m_draggingTarget.y = m_graphics.mouseY - 1;
				 if (KeyboardCatcher._isKeyPressed("17"))
				 {
					 m_draggingTarget.x = ((Math.round((m_graphics.mouseX-1)/10))*10);
					 m_draggingTarget.y = ((Math.round((m_graphics.mouseY-1)/10))*10);
					 m_draggingTargetPoint._xy = new Point(m_draggingTarget.x, m_draggingTarget.y+1);
				 }
				 clearGraphics();
				 redrawObject();
			 }
		}


		private function pointMouseOver(e:MouseEvent):void
		{
			(e.currentTarget as Sprite).alpha = 1;
		}


		private function pointMouseDown(e:MouseEvent):void
		{
			if (!m_adding) {
			for (var i:int=0; i<m_polygonGraphics.length; i++)
			{
				if (e.target == m_polygonGraphics[i])
				{
					m_draggingTarget = m_polygonGraphics[i];
					m_draggingTargetId = i+1;
					for each (var item:PolygonPoint in m_polygonPoints)
					{
						if (item._id == m_draggingTargetId)
						{
							m_draggingTargetPoint = item;
						}
					}
				}

			}
			if (KeyboardCatcher._isKeyPressed("18"))
			{
				_remove(m_draggingTargetPoint);
				refillGraphics();
				m_draggingTarget = null;
				m_draggingTargetPoint = null;
				m_draggingTargetId = 0;
			}
			} else {
				m_addorremove = true;
			}
		}




		private function pointMouseUp(e:MouseEvent):void
		{
			m_draggingTarget = null;
			m_draggingTargetId = 0;
			m_draggingTargetPoint = null;
		}

    public function _disabled():void {

    }
}
}
