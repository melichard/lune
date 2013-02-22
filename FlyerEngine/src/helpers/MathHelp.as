package helpers
{
	
	import flash.geom.Point;

	public class MathHelp
	{
        //prepona v pravouhlom trojuholniku
		public static function prepona(x:Number, y:Number):Number{
			return Math.sqrt( Math.pow(x, 2) + Math.pow(y, 2))
		}

		//uhol vektora od zaciatku (smer hore)
		public static function angle(x:Number, y:Number):Number{
			if (x == 0 && y < 0)
				return 0;
            if (x == 0 && y > 0)
                return Math.PI;
            if (y == 0 && x < 0)
                return -Math.PI/2;
            if (y == 0 && x > 0)
                return Math.PI/2;

			return (x/Math.abs(x))*Math.PI/2 + (Math.atan(Math.abs(y)/x))*(y/Math.abs(y))
		}

        //vektor z uhla od zaciatku
		public static function vectorFromRad(rot:Number, vel:Number):Point{
			return new Point(Math.sin(rot)*vel, Math.cos(rot)*vel*-1);
		}

        //otocenie bodu okolo ineho bodu
        public static function rotatePoint(point:Point, origin:Point, angle:Number):Point{
            var rotated:Point = new Point();
            var p:Point = new Point();
            p.x = point.x - origin.x;
            p.y = point.y - origin.y;
            var sin:Number = Math.sin(angle);
            var cos:Number = Math.cos(angle);
            rotated.x = p.x * cos - p.y * sin;
            rotated.y = p.x * sin + p.y * cos;
            rotated.x = origin.x + rotated.x;
            rotated.y = origin.y + rotated.y;
            return rotated;

        }
	}
}