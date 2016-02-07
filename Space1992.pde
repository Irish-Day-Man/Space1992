import controlP5.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

ControlP5 cp5;

//create ArrayList for game objects
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

//Create string variables
String movementDir;
String gameState;

//boolean to hold value
boolean enemyOnEdge;

//create variables to hold key status
boolean[] keys = new boolean[512];


void setup(){
  size(1600,900);
  cp5= new ControlP5(this);
  cp5.addButton("beginGame").setValue(1).setPosition(100,height-40).setSize(80,20).setLabel("Start Game");
  cp5.addButton("viewControls").setValue(2).setPosition(200, height-40).setSize(80,20).setLabel("View Controls");
  cp5.addButton("about").setValue(3).setPosition(300,height-40).setSize(80,20).setLabel("About");
  
  
}//end setup


void draw(){
  background(0);
  
}//end draw

void beginGame(){
  background(255,0,0);
  
}//end beginGame

void viewControls(){
  background(0,255,0);
  
}//end viewControls

void about(){
  background(0,0,255);
  
}//end about
