package maps
{
	import flash.geom.Point;

import helpers.LevelProvider;
import helpers.ObjectProvider;

import objects.GameObject;
    import objects.Planet;
	
	public class Map
	{
		protected var gObjects:Vector.<GameObject>; //vsetky objekt okrem planety a vevericky
		protected var planet:Planet;
		
		public function Map(id:int)
		{
            gObjects = LevelProvider.getObjects(id);
            planet = LevelProvider.getPlanet(id);
		}
		
		public function get getObjects():Vector.<GameObject>
		{
			return gObjects;
		}
		
		public function get getPlanet():Planet
		{
			return planet;
		}
	}
}