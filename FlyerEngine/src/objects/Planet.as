package objects
{
	import flash.geom.Point;

import starling.display.Image;

public class Planet extends GameObject
	{

		public function Planet(size:int)
		{

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
			super(new Point(),_type, size);
            _setTexture(_type);
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