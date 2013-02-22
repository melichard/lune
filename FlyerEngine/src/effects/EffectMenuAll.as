/**
 * Created with IntelliJ IDEA.
 * User: Tomas
 * Date: 18.1.2013
 * Time: 2:23
 * To change this template use File | Settings | File Templates.
 */
package effects {
import flash.display.BitmapData;
import flash.geom.Point;

import helpers.SettingsMaster;

import starling.display.Image;

import starling.display.Sprite;
import starling.textures.Texture;

public class EffectMenuAll extends Sprite {
    private var back:Sprite;
    private var front:Sprite;
    public function EffectMenuAll() {

        var nebulas:Sprite = new Sprite();

        var sun:Image = new Image(GraphicsLoader._getGraphicsGUI("menu/menu_sun"));
        sun.pivotX = sun.width/2;
        sun.pivotY = sun.height/2;
        sun.x = SettingsMaster._screenWidth/2;;
        sun.y = SettingsMaster._screenHeight/2-150;

        back = new Sprite();
        back.x = SettingsMaster._screenWidth/2;;
        back.y = SettingsMaster._screenHeight/2-170;;
        front = new Sprite();
        front.x = SettingsMaster._screenWidth/2;;
        front.y = SettingsMaster._screenHeight/2-170;;

        addChild(back);
        addChild(sun);
        addChild(front);
        addChild(nebulas)




        front.rotation = -Math.PI/32;

        back.rotation = -Math.PI/32;


        var component:EffectMenuPlanet = new EffectMenuPlanet(0.001, 300, 7, 0.2);
        var component2:EffectMenuPlanet = new EffectMenuPlanet(0.002, 400, 5, 0.21);
        var component3:EffectMenuPlanet = new EffectMenuPlanet(0.0015, 320, 8, 0.27);
        var component4:EffectMenuPlanet = new EffectMenuPlanet(0.0008, 490, 6, 0.2);
        var component5:EffectMenuPlanet = new EffectMenuPlanet(0.0013, 350, 5, 0.18);
        var component6:EffectMenuPlanet = new EffectMenuPlanet(0.0017, 370, 6, 0.21);
        var component7:EffectMenuPlanet = new EffectMenuPlanet(0.0024, 420, 7.5, 0.22);
        var component8:EffectMenuPlanet = new EffectMenuPlanet(0.001, 450, 8, 0.19);
        var component9:EffectMenuPlanet = new EffectMenuPlanet(0.0005, 390, 4, 0.31);
        var component10:EffectMenuPlanet = new EffectMenuPlanet(0.0010, 280, 3.8, 0.21);
        var component11:EffectMenuPlanet = new EffectMenuPlanet(0.0020, 330, 4, 0.26);
        var component12:EffectMenuPlanet = new EffectMenuPlanet(0.0022, 420, 4.8, 0.2);
        var component13:EffectMenuPlanet = new EffectMenuPlanet(0.0012, 430, 6.2, 0.3);
        var component14:EffectMenuPlanet = new EffectMenuPlanet(0.0014, 380, 5.1, 0.4);
        var component15:EffectMenuPlanet = new EffectMenuPlanet(0.0020, 510, 6.5, 0.32);
        var component16:EffectMenuPlanet = new EffectMenuPlanet(0.0011, 440, 7.25, 0.28);
        var component17:EffectMenuPlanet = new EffectMenuPlanet(0.0015, 480, 5.8, 0.45);
        var component18:EffectMenuPlanet = new EffectMenuPlanet(0.0006, 375, 5.2, 0.35);
        var component19:EffectMenuPlanet = new EffectMenuPlanet(0.0008, 408, 7.5, 0.2);
        var component20:EffectMenuPlanet = new EffectMenuPlanet(0.0019, 540, 8.6, 0.29);
        front.addChild(component);
        front.addChild(component2);
        front.addChild(component3);
        front.addChild(component4);
        front.addChild(component5);
        front.addChild(component6);
        front.addChild(component7);
        front.addChild(component8);
        front.addChild(component9);
        front.addChild(component10);
        front.addChild(component11);
        front.addChild(component12);
        front.addChild(component13);
        front.addChild(component14);
        front.addChild(component15);
        front.addChild(component16);
        front.addChild(component17);
        front.addChild(component18);
        front.addChild(component19);
        front.addChild(component20);
        addChild(front);

        component._sendBack.add(changePos);
        component2._sendBack.add(changePos);
        component3._sendBack.add(changePos);
        component4._sendBack.add(changePos);
        component5._sendBack.add(changePos);
        component6._sendBack.add(changePos);
        component7._sendBack.add(changePos);
        component8._sendBack.add(changePos);
        component9._sendBack.add(changePos);
        component10._sendBack.add(changePos);
        component11._sendBack.add(changePos);
        component12._sendBack.add(changePos);
        component13._sendBack.add(changePos);
        component14._sendBack.add(changePos);
        component15._sendBack.add(changePos);
        component16._sendBack.add(changePos);
        component17._sendBack.add(changePos);
        component18._sendBack.add(changePos);
        component19._sendBack.add(changePos);
        component20._sendBack.add(changePos);

        var nebula:EffectMenuNebula = new EffectMenuNebula(GraphicsLoader._getGraphicsGUI("menu/nebulas/nebula_over_1"));
        var nebula2:EffectMenuNebula = new EffectMenuNebula(GraphicsLoader._getGraphicsGUI("menu/nebulas/nebula_over_2"));
        var nebula3:EffectMenuNebula = new EffectMenuNebula(GraphicsLoader._getGraphicsGUI("menu/nebulas/nebula_over_3"));
        var nebula4:EffectMenuNebula = new EffectMenuNebula(GraphicsLoader._getGraphicsGUI("menu/nebulas/nebula_over_4"));
        var nebula5:EffectMenuNebula = new EffectMenuNebula(GraphicsLoader._getGraphicsGUI("menu/nebulas/nebula_over_5"));
        var nebula6:EffectMenuNebula = new EffectMenuNebula(GraphicsLoader._getGraphicsGUI("menu/nebulas/nebula_over_6"));
        var nebula7:EffectMenuNebula = new EffectMenuNebula(GraphicsLoader._getGraphicsGUI("menu/nebulas/nebula_over_7"));
        var nebula8:EffectMenuNebula = new EffectMenuNebula(GraphicsLoader._getGraphicsGUI("menu/nebulas/nebula_over_8"));

        nebulas.addChild(nebula);
        nebulas.addChild(nebula2);
        nebulas.addChild(nebula3);
        nebulas.addChild(nebula4);
        nebulas.addChild(nebula5);
        nebulas.addChild(nebula6);
        nebulas.addChild(nebula7);
        nebulas.addChild(nebula8);

        nebula._animate(new Point(-62+330,176+520), new Point(-62+730,480), 150, 50);
        nebula2._animate(new Point(-153+630,340+170), new Point(-153+130,360+190), 150, 50);
        nebula3._animate(new Point(263+630,185+190), new Point(263+230,185+380), 150, 50);
        nebula4._animate(new Point(-353+530,111+270), new Point(-453+530,111+0), 150, 50);
        nebula5._animate(new Point(0+620,110+370), new Point(0+480,110+200), 150, 50);
        nebula6._animate(new Point(-478+630,-69+470), new Point(-478+490,-69+290), 150, 50);
        nebula7._animate(new Point(406+530,-146+270), new Point(406+530,-146+0), 150, 50);
        nebula8._animate(new Point(369+380,172+370), new Point(369+530,250+0), 150, 50);

        nebulas.x = SettingsMaster._screenWidth/2-480;
        nebulas.y = SettingsMaster._screenHeight/2-270;


        if (SettingsMaster._screenWidth > 1200)
        {
            sun.scaleX = sun.scaleY = SettingsMaster._screenWidth/1200;
            back.scaleX = back.scaleY = SettingsMaster._screenWidth/1200;
            front.scaleX = front.scaleY = SettingsMaster._screenWidth/1200;
            nebulas.scaleX = nebulas.scaleY = SettingsMaster._screenWidth/1200;
        }

    }

    private function changePos(b:Boolean, planet:EffectMenuPlanet):void {
        if (b)
        {
            front.removeChild(planet);
            back.addChild(planet);
        } else {
            back.removeChild(planet);
            front.addChild(planet);
        }

    }
}
}
