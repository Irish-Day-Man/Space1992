import controlP5.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

ControlP5 cp5;

void setup(){
  size(1600,900);
  cp5= new ControlP5(this);
  cp5.addButton("beginGame").setValue(1).setPosition(100,height-40).setSize(80,20).setLabel("Start Game");
  cp5.addButton("viewControls").setValue(2).setPosition(200, height-40).setSize(80,20).setLabel("View Controls");
  cp5.addButton("about").setValue(3).setPosition(300,height-40).setSize(80,20).setLabel("About");
  
  
}//end setup


void draw(){
  
  
}//end draw
