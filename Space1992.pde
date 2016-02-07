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

//PImage to hold background image
PImage backgroundImage;

//PFont
PFont title;
PFont generalText;

Minim minim;
AudioPlayer player;

String songFile;


void setup(){
  size(1600,900);
  
  backgroundImage = loadImage("wizard.jpg");
  image(backgroundImage,0,0);
  
  minim= new Minim(this);
  player= minim.loadFile("InfernusAdAstra.mp3",2048);
  player.loop();
  
  //add menu items
  cp5= new ControlP5(this);
  cp5.addButton("beginGame").setValue(1).setPosition(100,height-40).setSize(80,20).setLabel("Start Game");
  cp5.addButton("viewControls").setValue(2).setPosition(200, height-40).setSize(80,20).setLabel("View Controls");
  cp5.addButton("about").setValue(3).setPosition(300,height-40).setSize(80,20).setLabel("About");
  
  //set up fonts
  title = createFont("pdark.ttf",33);
  textFont(title);
  fill(0);
  textAlign(CENTER);
  text("Space 1992: The Rise of The Chaos Wizards!", width/2, 100);
  fill(129,254,166);
  textSize(32);
  text("Space 1992: The Rise of The Chaos Wizards!", width/2, 100);
  
  
  
}//end setup


void draw(){
  
  
}//end draw

void beginGame(){
  
  
}//end beginGame

void viewControls(){
  
  
}//end viewControls

void about(){
  
  
}//end about
