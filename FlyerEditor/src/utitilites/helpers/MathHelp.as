package utitilites.helpers
{

import flash.geom.Point;

public class MathHelp
	{

        public static function bodyRovnakejPolroviny(pointA:Point, pointB:Point, lineDefinitonAB:Point):Boolean
        {
            var r:Boolean;
            if ((pointA.y <= (pointA.x*lineDefinitonAB.x + lineDefinitonAB.y) && pointB.y <= (pointB.x*lineDefinitonAB.x + lineDefinitonAB.y)) ||
            (pointA.y > (pointA.x*lineDefinitonAB.x + lineDefinitonAB.y) && pointB.y > (pointB.x*lineDefinitonAB.x + lineDefinitonAB.y)))
            {
                r =  true;
            } else
            {
                r = false;
            }
            return r;
        }

        public static function osUhlaTrochBodov(bodA:Point,  bodB:Point, bodC:Point):Point
        {
            var pomer:Number = prepona(bodC.x-bodB.x,bodC.y-bodB.y)/prepona(bodA.x-bodB.x,bodA.y-bodB.y);
            var bodD:Point = new Point(bodB.x + pomer*(bodA.x-bodB.x), bodB.y + pomer*(bodA.y-bodB.y));
            var r:Point = new Point((bodD.x + bodC.x) / 2 - bodB.x, (bodD.y + bodC.y) / 2 - bodB.y);
            return r;
        }
        //prepona v pravouhlom trojuholniku
		public static function prepona(x:Number, y:Number):Number{
			return Math.sqrt( Math.pow(x, 2) + Math.pow(y, 2))
		}

		//uhol vektora od zaciatku (smer hore)
		public static function angle(x:Number, y:Number):Number{
			if (x == 0 && y < 0)
				return 0;
            if (x == 0 && y >= 0)
                return Math.PI;
            if (y == 0 && x < 0)
                return -Math.PI/2;
            if (y == 0 && x > 0)
                return Math.PI/2;

			return (x/Math.abs(x))*Math.PI/2 + (Math.atan(Math.abs(y)/x))*(y/Math.abs(y))
		}
        //vektor z uhla od zaciatku
		public static function vectorFromRad(rot:Number, vel:Number):Point{
			return new Point(Math.sin(rot)*vel, Math.cos(rot)*vel*-1)
		}

        //otocenie bodu okolo ineho bodu
        public static function rotatePoint(point:Point, origin:Point, angle:Number):Point{
            var rotated:Point = new Point();
            var p:Point = new Point();
            p.x = point.x - origin.x;
            p.y = point.y - origin.y;
            rotated.x = p.x * Math.cos(angle) - p.y * Math.sin(angle);
            rotated.y = p.x * Math.sin(angle) + p.y * Math.cos(angle);
            rotated.x = origin.x + rotated.x;
            rotated.y = origin.y + rotated.y;
            return rotated;

        }

    public static function koeficientyPriamkyZBodov(bodA:Point, bodB:Point):Point {
        var a:Number = (bodA.y-bodB.y)/(bodA.x - bodB.x);
        var b:Number = bodA.y - a*bodA.x;
        return new Point(a,b);
    }
}
}