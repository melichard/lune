package objects {
import flash.display.BitmapData;
import flash.display3D.textures.Texture;
import flash.geom.Point;

import helpers.MathHelp;
import helpers.OnFrame;

import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

public class Polygon extends Sprite{
    public var points:Vector.<Point>;
    public var gameObject:GameObject;
	private var bitmapdata:BitmapData;
	public var images:Vector.<Image>;

    public function Polygon(gameObject:GameObject) {
        points = new Vector.<Point>();
        this.gameObject = gameObject;
		//bitmapdata =  new BitmapData(5,5,false,0xFF0000);
		//images = new Vector.<Image>();
		//for (var a:int = 0; a < 10; a++)
		//{
		//	images.push(new Image(starling.textures.Texture.fromBitmapData(bitmapdata)));
		//	
		//	addChild(images[a]);
		//}
    }

    public function addPoint(point:Point):void
    {
        points.push(point);

    }

    public function collides(polygon2:Polygon):Boolean
    {
		var gameObject2:GameObject = polygon2.gameObject;
		
		var points2:Vector.<Point> = polygon2.points;
        
        var currentPosition:Point = new Point(gameObject.x, gameObject.y)
        var currentPosition2:Point = new Point(gameObject2.x, gameObject2.y);

        var rayPositionx:Number = 0;
        var rayPositiony:Number = 0;
		var globalPoints:Vector.<Point> = new Vector.<Point>();
		var globalPoints2:Vector.<Point> = new Vector.<Point>();
		var globalFirst:Point = new Point();
		var globalSecond:Point = new Point();
		
		var intersect:Point = new Point(0,0);
		
		var plength:int = points.length;
        var p2points:Vector.<Point> = polygon2.points;
		var p2length:int = p2points.length;
		
		var i:int = 0;
		var k:int = 0;
        var sin:Number;
        var cos:Number;
        var rotatedx:Number;
        var rotatedy:Number;
		
		for (i = 0; i < plength; i++)
		{
            sin = Math.sin(gameObject.rotation);
            cos = Math.cos(gameObject.rotation);
            rotatedx = points[i].x * cos - points[i].y * sin;
            rotatedy = points[i].x * sin + points[i].y * cos;
            rotatedx = currentPosition.x + rotatedx;
            rotatedy = currentPosition.y + rotatedy;
            var newPoint:Point = new Point(rotatedx, rotatedy);
            globalPoints.push(newPoint);
			//trace(currentPosition + " " + globalPoints[i]);
			//images[i].x = globalPoints[i].x;
			//images[i].y = globalPoints[i].y;
		}
		
        for (i = 0; i < p2length; i++)
        {
            sin = Math.sin(gameObject2.rotation);
            cos = Math.cos(gameObject2.rotation);
            rotatedx = points2[i].x * cos - points2[i].y * sin;
            rotatedy = points2[i].x * sin + points2[i].y * cos;
            rotatedx = currentPosition2.x + rotatedx;
            rotatedy = currentPosition2.y + rotatedy;
            newPoint = new Point(rotatedx, rotatedy);
            globalPoints2.push(newPoint);
            //gameObject2.polygon.images[i].x = globalPoints2[i].x;
			//gameObject2.polygon.images[i].y = globalPoints2[i].y;
            rotatedx = newPoint.x;
            rotatedy = newPoint.y;
			if (rotatedx > rayPositionx)
                rayPositionx = rotatedx;
            if (rotatedy > rayPositiony)
                rayPositiony = rotatedy;
        }

        rayPositionx += 10;
        rayPositiony += 10;

		var det:Number;
		var detA:Number;
		var detB:Number;
		var a:Number;
		var b:Number;
		var interCount:int
		
		var det2:Number;
		var detA2:Number;
		var detB2:Number;
		var c:Number;
		var d:Number;

        var distx:Number, disty:Number, dist1:Number, dist2:Number;
		
        for (i = 0; i < plength; i++)
        {
            var globalPoint:Point = globalPoints[i];
            det = rayPositionx - globalPoint.x;
            if (det == 0)
            {
                //trace ("det = 0");
            }
            detA = rayPositiony - globalPoint.y;
            detB = rayPositionx*globalPoint.y - rayPositiony*globalPoint.x;
            a = detA/det;
            b = detB/det;

            interCount = 0;
            for (k = 0; k < p2length; k++)
			{
				globalFirst = globalPoints2[k];
                if (k < p2length - 1)
                    globalSecond = globalPoints2[k+1];
                else
                    globalSecond = globalPoints2[0];
                det2 = globalFirst.x - globalSecond.x;
                if (det2 == 0)
                {
                    //trace ("det2 = 0");
                }
                detA2 = globalFirst.y - globalSecond.y;
                detB2 = globalFirst.x*globalSecond.y - globalFirst.y*globalSecond.x;
                c = detA2/det2;
                d = detB2/det2;
                intersect.x = (d - b)/(a - c);
                intersect.y = b + a*intersect.x;
                distx = intersect.x - rayPositionx;
                disty = intersect.y - rayPositiony;
                dist1 = Math.sqrt(distx*distx + disty*disty);
                distx = globalPoints[i].x - rayPositionx;
                disty = globalPoints[i].y - rayPositiony;
                dist2 = Math.sqrt(distx*distx + disty*disty);
				if (dist1 < dist2)
				{
					if ((rayPositionx - intersect.x > 0 && rayPositionx - globalPoint.x > 0 )||
						(rayPositionx - intersect.x < 0 && rayPositionx - globalPoint.x < 0))
					{
		                if (globalFirst.x != globalSecond.x)
		                {
		                    if (intersect.x < globalFirst.x && intersect.x > globalSecond.x && globalFirst.x > globalSecond.x)
		                         interCount++;
		                    if (intersect.x > globalFirst.x && intersect.x < globalSecond.x && globalFirst.x < globalSecond.x)
		                         interCount++;
		                } else
		                {
		                    if (intersect.y < globalFirst.y && intersect.y > globalSecond.y && globalFirst.y > globalSecond.y)
		                        interCount++;
		                    if (intersect.y > globalFirst.y && intersect.y < globalSecond.y && globalFirst.y < globalSecond.y)
		                        interCount++;
		                }
						
					}
				}
            }
            if (interCount % 2 == 1)
                return true;
        }
        /*
        for (var i:int = 0; i < points.length; i++)
        {
            //dva body urcujuce hranu
            var globalRef:Point = MathHelp.rotatePoint(new Point(points[i].x + gameObject.x, points[i].y + gameObject.y), currentPosition, gameObject.rotation);
            var globalNext:Point;
            if (i < points.length - 1)
                globalNext = MathHelp.rotatePoint(new Point(points[i+1].x + gameObject.x, points[i+1].y + gameObject.y), currentPosition, gameObject.rotation);
            else
                globalNext = MathHelp.rotatePoint(new Point(points[0].x + gameObject.x, points[0].y + gameObject.y), currentPosition, gameObject.rotation);
            //vektor hrany
            var edge:Point = new Point(globalNext.x - globalRef.x , globalNext.y - globalRef.y);
            //uhol, ktory zviera hrana s pociatkom (smer hore)
            var rad:Number = MathHelp.angle(edge.x,  edge.y);
            //vektory pre otocene body
            var transformed1:Vector.<Point> = new Vector.<Point>;
            var transformed2:Vector.<Point> = new Vector.<Point>;
            //rotacia bodov prveho telesa
            for each (var point:Point in points)
            {
                var globalPoint:Point = MathHelp.rotatePoint(new Point(gameObject.x + point.x, gameObject.y + point.y), currentPosition, gameObject.rotation);

                transformed1.push(MathHelp.rotatePoint(globalPoint,  globalRef, -rad));
            }
            //rotacia bodov druheho telesa
            for each (point in polygon2.points)
            {
                globalPoint = MathHelp.rotatePoint(new Point(polygon2.gameObject.x + point.x, polygon2.gameObject.y + point.y), currentPosition2, polygon2.gameObject.rotation);
                transformed2.push(MathHelp.rotatePoint(globalPoint,  globalRef, -rad));
            }

            //max, min pre obe telesa
            var max1:Number = 0;
            var max2:Number = 0;
            var min1:Number = 960;
            var min2:Number = 960;

            for each (point in transformed1)
            {
                if (point.x > max1)
                    max1 = point.x;
                if (point.x < min1)
                    min1 = point.x;
            }

            for each (point in transformed2)
            {
                if (point.x > max2)
                    max2 = point.x;
                if (point.x < min2)
                    min2 = point.x;
            }

            if ((max1 > min2 && min1 < max2)||( max2 > min1 && min2 < max1))
                collision = true;
            else
                return false;

        }

        for (i = 0; i < polygon2.points.length; i++)
        {
            //dva body urcujuce hranu

            globalRef = MathHelp.rotatePoint(new Point(polygon2.points[i].x + polygon2.gameObject.x, polygon2.points[i].y + polygon2.gameObject.y), currentPosition2, polygon2.gameObject.rotation);
            if (i < points.length - 1)
                globalNext = MathHelp.rotatePoint(new Point(polygon2.points[i+1].x + polygon2.gameObject.x, polygon2.points[i+1].y + polygon2.gameObject.y), currentPosition2, polygon2.gameObject.rotation);
            else
                globalNext = MathHelp.rotatePoint(new Point(polygon2.points[0].x + polygon2.gameObject.x, polygon2.points[0].y + polygon2.gameObject.y), currentPosition2, polygon2.gameObject.rotation);
            //vektor hrany
            edge = new Point(globalNext.x - globalRef.x , globalNext.y - globalRef.y);
            //uhol, ktory zviera hrana s pociatkom (smer hore)
            rad = MathHelp.angle(edge.x,  edge.y);
            //vektory pre otocene body
            transformed1 = new Vector.<Point>;
            transformed2 = new Vector.<Point>;
            //rotacia bodov prveho telesa
            for each (point in points)
            {
                globalPoint = MathHelp.rotatePoint(new Point(gameObject.x + point.x, gameObject.y + point.y), currentPosition, gameObject.rotation);
                //trace(globalPoint + " asdasd ");
                transformed1.push(MathHelp.rotatePoint(globalPoint,  globalRef, -rad));
                //trace(MathHelp.rotatePoint(globalPoint,  globalRef, -rad)) ;
            }
            //rotacia bodov druheho telesa
            for each (point in polygon2.points)
            {
                globalPoint = MathHelp.rotatePoint(new Point(polygon2.gameObject.x + point.x, polygon2.gameObject.y + point.y), currentPosition2, polygon2.gameObject.rotation);
                transformed2.push(MathHelp.rotatePoint(globalPoint,  globalRef, -rad));
            }

            //max, min pre obe telesa
            max1 = -1200;
            max2 = -1200;
            min1 = 1800;
            min2 = 1800;

            for each (point in transformed1)
            {
                if (point.x > max1)
                    max1 = point.x;
                if (point.x < min1)
                    min1 = point.x;
            }

            for each (point in transformed2)
            {
                if (point.x > max2)
                    max2 = point.x;
                if (point.x < min2)
                    min2 = point.x;
            }

            if ((max1 > min2 && min1 < max2)||( max2 > min1 && min2 < max1))
                collision = true;
            else
                return false;   */



        return false;

    }

	
	
	public final function rotatePoint(point:Point, origin:Point, angle:Number):Point{
		var px:Number;
		var py:Number;
		var ox:Number = origin.x;
		var oy:Number = origin.y;
		var sin:Number;
		var cos:Number;
		var rotatedx:Number;
		var rotatedy:Number;
		px = point.x - ox;
		py = point.y - oy;
		sin = Math.sin(angle);
		cos = Math.cos(angle);
		rotatedx = px * cos - py * sin;
		rotatedy = px * sin + py * cos;
		rotatedx = ox + rotatedx;
		rotatedy = oy + rotatedy;
		return new Point(rotatedx, rotatedy);		
	}
	
	public final function distance(point:Point, point2:Point):Number
	{
		var x:Number = point2.x - point.x;
		var y:Number = point2.y - point.y;
		return Math.sqrt(x*x + y*y);
	}
	
}
}
