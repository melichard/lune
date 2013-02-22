package utitilites {
import maps.Map;

import objects.GameObject;

public class CustomMap extends Map {

    public function CustomMap(objects:Vector.<objects.GameObject>, planetDef:objects.Planet) {
        super(1);
        gObjects = objects;
        planet = planetDef
    }
}
}
