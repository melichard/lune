package objects.enemies {
import flash.geom.Point;

public class RangedEnemy extends Enemy
{
    private var counter:int;

    public function RangedEnemy(position:Point) {
        super (position);

        counter = 0;
    }

    protected override function _onFrame():void
    {
        if (counter == 300)
        {
            counter = 0;
            _shoot();
        }

        counter++;
    }

    private function _shoot():void
    {

    }
}
}
