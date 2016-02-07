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
  
  generalText = createFont("cs.ttf", 32);
  textFont(generalText);
  text("In the distant future of the year 1992, War has returned to the galaxy...\nThe evil wizard Zargothrax has broken free from his prison of liquid ice on Saturn's moon Triton\nand has raised an army of chaos wizards to conquer the galaxy\nCan you, as the legendary hero, Angus McFife XIII,\nsave the mighty citadel of Dundee and the rest of the Galaxy?\nRide forth for the eternal glory of Dundee!", width/2, 300);
  gameState = "homeScreen";
  
}//end setup


void draw(){
  image(backgroundImage,0,0);
  if(gameState.matches("homeScreen")){
    //set up fonts
    title = createFont("pdark.ttf",33);
    textFont(title);
    fill(0);
    textAlign(CENTER);
    text("Space 1992: The Rise of The Chaos Wizards!", width/2, 100);
    fill(129,254,166);
    textSize(32);
    text("Space 1992: The Rise of The Chaos Wizards!", width/2, 100);
    
    generalText = createFont("cs.ttf",32);
    textFont(generalText);
    text("In the distant future of the year 1992, War has returned to the galaxy...\nThe evil wizard Zargothrax has broken free from his prison of liquid ice on Saturn's moon Triton\nand has raised an army of chaos wizards to conquer the galaxy\nCan you, as the legendary hero, Angus McFife XIII,\nsave the mighty citadel of Dundee and the rest of the Galaxy?\nRide forth for the eternal glory of Dundee!", width/2, 300);   
    
  }//end while

  else if(gameState.matches("gameOn")){
    image(backgroundImage,0,0);
    cp5.hide();
    
  }//end while
  
  else if(gameState.matches("gameOver")){
    image(backgroundImage,0,0);
    title = createFont("pdark.ttf",33);
    textFont(title);
    fill(0);
    textAlign(CENTER);
    text("Space 1992: The Rise of The Chaos Wizards!", width/2, 100);
    fill(129,254,166);
    textSize(32);
    text("Space 1992: The Rise of The Chaos Wizards!", width/2, 100);
    
    generalText = createFont("cs.ttf", 32);
    textFont(generalText);
    text("You have failed!!!\nThe Evil Wizard Zargothrax has succeeded in his quest to conquer\n The Mighty Scottish Citadel of Dundee and the rest of the galaxy...\n Zargothrax now rides forth to conquer the universe\nwith his Chaos wizards atop undead unicorns of war...",width/2,300);
  }//end while

}//end draw

void beginGame(){
  gameState=("gameOn");
  
}//end beginGame

void viewControls(){
  gameState=("gameOver");
  
}//end viewControls

void about(){
  
  
}//end about
