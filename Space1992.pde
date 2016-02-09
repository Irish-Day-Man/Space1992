import controlP5.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

ControlP5 cp5;
ControlP5 cp6;

int wizDestroyed = 0;

//create ArrayList for game objects
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

//Create string variables
static String movementDir="r";
static String gameState;
static int score = 0;

//int array for holding hiscore


//boolean to hold value
boolean enemyOnEdge;
boolean antiAutoPlay = false;

//create variables to hold key status
boolean[] keys = new boolean[512];

//PImage to hold background image
PImage backgroundImage;

//PFont
PFont title;
PFont generalText;

String[] hiScorez;

Minim minim;
AudioPlayer player;

String songFile;

float centerX = 1600/2-40;
float heightVal = 900-150;

AngusMcFife hero = new AngusMcFife('A','D',' ', centerX, heightVal);

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
  cp5.addButton("about").setValue(0).setPosition(300,height-40).setSize(80,20).setLabel("About");
  cp5.addButton("hiScores").setValue(3).setPosition(400,height-40).setSize(80,20).setLabel("Hi-Scores");

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
  
  readInData();
  
  for(int i=0;i<hiScorez.length;i++){
    System.out.println(hiScorez[i]);
    
  }//end for
  
}//end setup


void draw(){
  if(frameCount>5){
    antiAutoPlay = true;
    
  }//end if
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
    
  }//end if

  else if(gameState.matches("gameOn")){
    
    cp5.hide();
    for(int i=gameObjects.size()-1; i>=0; i--){
      GameObject go = gameObjects.get(i);
      go.update();
      go.render();
      checkWizardDeath(); 
      checkPlayerDeath();
      
      if(wizDestroyed==20){
        cp5.show();
        gameState="victory";
        
      }//end if
      
    }//end for
        
    stroke(255);
    noFill();
    rect(400,0,880,850);
    textAlign(LEFT);
    textFont(title);
    fill(129,254,166);
    textSize(16);
    
    text("Score: " + score ,100,400);
    if(frameCount%90==0){
      
      if(frameCount>420){
      
        if(enemyOnEdge == true){
          for(int i=gameObjects.size()-1;i>=0;i--){
            GameObject go = gameObjects.get(i);
            if(go instanceof ChaosWizard){
              go.pos.y+=50;
              
              if(go.pos.y>650){
                gameState = "gameOver";
                getInfernusAdAstra();
                
              }//end if
              
             
            }//end if 
            enemyOnEdge=false;
          }//end for
             
        }//end if
        
      }//end framecount>300
    }//end if
    
    
  }//end else if
  
  else if(gameState.matches("hiScores")){
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
    
    text("Hi Scores: ",width/2, 250);
    
    for(int i=0;i<hiScorez.length;i++){
          text((i+1) + ": " + hiScorez[i],width/2,300 + (40*i));      
      
    }//end for
    
  }//end if
  
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
    
    for(int i=gameObjects.size()-1;i>=0;i--){
      GameObject go = gameObjects.get(i);
      gameObjects.remove(go);
    
    }//end for
    
    cp5.show();
    
  }//end else if
  
  else if(gameState.matches("aboutGame")){
    image(backgroundImage,0,0);
    textFont(title);
    textAlign(CENTER);
    textSize(33);
    fill(0);
    text("About",width/2,100);
    textSize(32);
    fill(129,254,166);
    text("About", width/2,100);
    
    textAlign(LEFT);
    textFont(generalText);
    text("This game is based on the 2015 album: \"Space 1992: The Rise of The Chaos Wizards!\"\nBy the Scottish power metal band: Gloryhammer.\n\nThis game is inspired by the classic arcade game: \"Space Invaders\".\n\nThe Gloryhammer songs featured in this album are:\nMenu Song:\n\t\t* Infernus Ad Astra\n\nGame songs:\n\t\t* Rise of The Chaos Wizards\n\t\t* Legend of The Astral Hammer\n\t\t* The Hollywood Hootsman\n\t\t* Universe On Fire",200,300);
    
    
  }//end else if
  
  else if(gameState.matches("viewControls")){
    image(backgroundImage,0,0);
    textAlign(CENTER);
    fill(0);
    textFont(title);
    textSize(33);
    text("Space 1992: The Rise of The Chaos Wizards!", width/2, 100);
    fill(129,254,166);
    textSize(32);
    text("Space 1992: The Rise of The Chaos Wizards!", width/2,100);
    
    //textFont(generalText);
    textAlign(LEFT);
    textSize(12);
    pushMatrix();
    translate(width/4,height/3);
    AngusMcFife hero = new AngusMcFife('.','.','.',0,0);
    hero.render();
    
    fill(129,254,166);
    text("This is you, Angus McFife XIII, Crown Prince of the mighty kingdom of Dundee\n\n\t   SPACE - Swing your mighty Astral Hammer to defeat the Chaos Wizards\n\t   A / D - Move from side to side to dodge the unholy chaos lightning",100,0);
    
    popMatrix();
        
  }//end else if
  
  else if(gameState.matches("victory")){
    image(backgroundImage,0,0);
    textAlign(CENTER);
    fill(0);
    textFont(title);
    textSize(33);
    text("Victory!",width/2,100);
    fill(129,254,166);
    textSize(32);
    text("Victory!",width/2,100);
    
    generalText = createFont("cs.ttf", 32);
    textFont(generalText);
    text("And with a thunderous implosion, Angus McFife swings his Astral Hammer and decimates the very existence of the Evil Wizard Zargothrax\nReleasing his control over his army of undead unicorns and his control over his undead army of Chaos Wizards\nAngus McFife is once again victorious and has once again protected the mighty citadel of Dundee and its eternal glory!",width/2,300);
    
    

    
  }//end else if

}//end draw

void beginGame(){
  wizDestroyed = 0;
  gameState=("gameOn");
  score=0;
  for(int i=gameObjects.size()-1;i>=0;i--){
    gameObjects.remove(i);
    
  }//end for
  image(backgroundImage,0,0);
  gameObjects.add(hero);
  hero.pos.x= centerX;
  createEnemies();
  score=0;
  randomSong();
  
}//end beginGame

void viewControls(){
  gameState=("viewControls");
  
}//end viewControls

void about(){  
  gameState=("aboutGame");
  
}//end about

void createEnemies(){
  for(int i=400;i<900;i+=100){
    for(int j=0;j<400;j+=100){
      ChaosWizard enemy = new ChaosWizard(i, j);
      gameObjects.add(enemy);

    }//end for
    
  }//end for
  
}//end createEnemies

void randomSong(){
  if(antiAutoPlay){
    int i = int(random(0,4));
    if(i==0){
      songFile="RiseOfTheChaosWizards.mp3";
      
    }//end if
    
    else if (i==1){
      songFile="LegendOfTheAstralHammer.mp3";
      
    }//end else if
    
    else if(i==2){
      songFile="TheHollywoodHootsman.mp3";
      
    }//end else if
    
    else if(i==3){
      songFile = "UniverseOnFire.mp3";
      
    }//end else if
    
    player.pause();
    player = minim.loadFile(songFile,2048);
    player.loop();
    
  }//end if
  

}//end randomSong

void getInfernusAdAstra(){
  songFile="InfernusAdAstra.mp3";
  
  player.pause();
  player = minim.loadFile(songFile, 2048);
  player.loop();
  
}//end getInfernusAdAstra

void keyPressed(){
  keys[keyCode]= true;
  
}//end 

void keyReleased(){
  keys[keyCode]=false;
  
}//end keyreleased

void checkPlayerDeath(){
  for(int i = gameObjects.size()-1;i>=0;i--){
    GameObject lightning = gameObjects.get(i);
    
    if(lightning instanceof ChaosBolt){
      for(int j = gameObjects.size()-1;j>=0;j--){
        GameObject angus = gameObjects.get(j);
        
        if(angus instanceof AngusMcFife){
          if(lightning.pos.x > angus.pos.x && lightning.pos.x<angus.pos.x + angus.objWidth && lightning.pos.y + 40> angus.pos.y && lightning.pos.y + 40 < angus.pos.y + angus.objHeight){
            gameObjects.remove(i);
            gameState = "gameOver";
                        
          }
          
        }//end if
        
      }//end for
      
    }//end if
    
  }//end for
   
}//end checkCollisions

void checkWizardDeath(){
  for(int i = gameObjects.size()-1; i>=0; i--){
    GameObject hammer = gameObjects.get(i);
    
    if(hammer instanceof AstralHammer){
      for(int j= gameObjects.size()-1; j>=0; j--){
        GameObject wizard =gameObjects.get(j);
        
        if(wizard instanceof ChaosWizard){
          if(hammer.pos.x> wizard.pos.x && hammer.pos.x < wizard.pos.x + wizard.objWidth && hammer.pos.y> wizard.pos.y && hammer.pos.y < wizard.pos.y + wizard.objHeight){
            
            gameObjects.remove(wizard);
            hammer.pos.x=500000;
            
            score+=105;
            wizDestroyed+=1;
            
            
          }//end if
          
        }//end if
        
      }//end for
      
    }//end if
    
  }//end for
  
}//end checkWizardDeath

void readInData(){
  hiScorez = loadStrings("hiScores.txt");
  for(int i=0;i<hiScorez.length;i++){
    System.out.println("Hello"+ hiScorez[i]);
    
    
    
    
  }//end for
    
}//end readInData

void hiScores(){
  gameState="hiScores";  
  
}//end hiScores
