package objects
{
	import flash.geom.Point;

import starling.display.Image;

public class Planet extends GameObject
	{
        private var _radius:Number;

		public function Planet(size:int)
		{
            _radius = size;

            var _type:String;
            switch (size){
                case(200):
                    _type = "planet_mini"; break;
                case(350):
                    _type = "planet_small"; break;
                case(480):
                    _type = "planet_medium"; break;
                case(500):
                    _type = "planet_large"; break;

            }
			super(new Point());
            _setTexture(_type);
		}

        public function get radius():Number
        {
            return _radius;
        }

        protected override function _setTexture(type:String):void
        {
            _texture = new Image(GraphicsLoader.getPlanet(type));
            pivotX = _texture.width/2;
            pivotY = _texture.height/2;
            this.addChild(_texture);
        }
	}
}