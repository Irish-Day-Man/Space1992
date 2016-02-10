//importing libraries
import controlP5.*;

import java.io.File;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//controlp5 object to hold menu items
ControlP5 cp5;

//int to count how many wizards are destroyed to determine if game should end
int wizDestroyed = 0;

//create ArrayList for game objects
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

//Create string variables to 
static String movementDir="r";
static String gameState;

//variable to hold the score
static int score = 0;

//boolean to confirm if game is played
boolean gamePlayed= false;


//boolean to hold values to control game
boolean enemyOnEdge;
boolean antiAutoPlay = false;

//create variables to hold key status
boolean[] keys = new boolean[512];

//PImage to hold background image
PImage backgroundImage;

//PFont objects
PFont title;
PFont generalText;


//string to hold HiScore values
String[] hiScorez;

//sound related objects
Minim minim;
AudioPlayer player;
String songFile;

//values for the player character, angus mcFife, XIII of his name
float centerX = 1600/2-40;
float heightVal = 900-150;

AngusMcFife hero = new AngusMcFife('A','D',' ', centerX, heightVal);

void setup(){
  //set window size
  size(1600,900);
  
  //set up background image
  backgroundImage = loadImage("wizard.jpg");
  image(backgroundImage,0,0);
  
  //play infernus ad astra
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
  
  //read in hi-score data
  readInData();
  
}//end setup


void draw(){
  //Stops a bug that caused the game to automatically begin if the game started
  if(frameCount>5){
    antiAutoPlay = true;
    
  }//end if
  
  //resets background image
  image(backgroundImage,0,0);
  
  //if game is in homeScreen area
  if(gameState.matches("homeScreen")){
    
    //set up title
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
    
    //hide menu
    cp5.hide();
    
    //for loop to update/render objects and detect collisions
    for(int i=gameObjects.size()-1; i>=0; i--){
      GameObject go = gameObjects.get(i);
      go.update();
      go.render();
      checkWizardDeath(); 
      checkPlayerDeath();
      
      //check if game should end
      if(wizDestroyed==20){
        cp5.show();
        gameState="victory";
        
      }//end if
      
    }//end for
    
    //show score
    stroke(255);
    noFill();
    rect(400,0,880,850);
    textAlign(LEFT);
    textFont(title);
    fill(129,254,166);
    textSize(16);
    
    text("Score: " + score ,100,400);
    
    //code to change the movement direction of spooky chaos wizards
    if(frameCount%90==0){
      
      if(frameCount>420){
      
        if(enemyOnEdge == true){
          for(int i=gameObjects.size()-1;i>=0;i--){
            GameObject go = gameObjects.get(i);
            if(go instanceof ChaosWizard){
              go.pos.y+=50;
              
              //check if spooky chaos wizards win
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
  
  //display hiscores section
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
    
    //display hi scorezzzzzz
    for(int i=0;i<hiScorez.length;i++){
          text((i+1) + ": " + hiScorez[i],width/2,300 + (40*i));      
      
    }//end for
    
  }//end if
  
  //if player loses
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
    
    //clear out gameObjects
    for(int i=gameObjects.size()-1;i>=0;i--){
      GameObject go = gameObjects.get(i);
      gameObjects.remove(go);
    
    }//end for
    
    //show menu again
    cp5.show();
    
  }//end else if
  
  //display about section
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
    
    //display information space 1992: The Rise of The Chaos Wizards
    textAlign(LEFT);
    textFont(generalText);
    text("This game is based on the 2015 album: \"Space 1992: The Rise of The Chaos Wizards!\"\nBy the Scottish power metal band: Gloryhammer.\n\nThis game is inspired by the classic arcade game: \"Space Invaders\".\n\nThe Gloryhammer songs featured in this album are:\nMenu Song:\n\t\t* Infernus Ad Astra\n\nGame songs:\n\t\t* Rise of The Chaos Wizards\n\t\t* Legend of The Astral Hammer\n\t\t* The Hollywood Hootsman\n\t\t* Universe On Fire",200,300);
    
  }//end else if
  
  //display controls
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
    
    //translate the matrix
    translate(width/4,height/3);
    
    //show angus mc fife
    AngusMcFife hero = new AngusMcFife('.','.','.',0,0);
    hero.render();
    
    fill(129,254,166);
    text("This is you, Angus McFife XIII, Crown Prince of the mighty kingdom of Dundee\n\n\t   SPACE - Swing your mighty Astral Hammer to defeat the Chaos Wizards\n\t   A / D - Move from side to side to dodge the unholy chaos lightning",100,0);
    
    //show spooky chaosWizards
    ChaosWizard spookyGhostWizard = new ChaosWizard(0,150);
    spookyGhostWizard.render();
    fill(129,254,166);
    text("This is a Chaos Wizard, eternally loyal to the evil wizard Zargothrax.\nThese will shoot spooky chaos lightning which is not good for yon and will result in a painful death",100,200);
    
    popMatrix();
    //pop the matrix
        
  }//end else if
  
  //if gamestate is victory
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
    
    //display enthusiastic victory text
    generalText = createFont("cs.ttf", 32);
    textFont(generalText);
    text("And with a thunderous implosion, Angus McFife swings his Astral Hammer\n and decimates the very existence of the Evil Wizard Zargothrax\nReleasing his control over his army of undead unicorns\n and his control over his army of Chaos Wizards\n\nAngus McFife is once again victorious and has once again,\n protected the mighty citadel of Dundee and its eternal glory!",width/2,300);
    
    //stops hiscores from being auto matically written and wrecking the file
    if(gamePlayed == true){
      //check if hiScore was beaten
      if(score>Integer.parseInt(hiScorez[2])){
        text("You achieved a high score!",width/2,500);
        
        boolean flag = true;
        int temp;
        int [] tempScores = new int[4];
        tempScores[3] = score;
        
        for(int i=0;i<3;i++){
          tempScores[i] = Integer.parseInt(hiScorez[i]);
          
        }//end for
        
        //bubble sort to sort hiscores to determine the lowest that needs to be removed
        while(flag){
         
          flag=false;
          for(int j=0;j<tempScores.length-1;j++){
            if(tempScores[j] < tempScores[j+1]){
              temp=tempScores[j];
              tempScores[j] = tempScores[j+1];
              tempScores[j+1] = temp;
              flag= true;
              
            }//end if
            
          }//end for
          
        }//end while
        
        for(int i=0;i<tempScores.length-1;i++){
          hiScorez[i]= Integer.toString(tempScores[i]);
          
        }//end for
        
        //set up file name
        String fileName = dataPath("hiScores.txt");
        
        //create java file based on file path
        File f = new File(fileName);
        
        //delete file if it already exists
        if(f.exists()){
          f.delete();
          
        }//end if
        
        //create printwriter object and output hiscores
        PrintWriter output;
        output = createWriter(fileName);
        for(int i=0;i<hiScorez.length;i++){
          if(i<=1){
            output.println(hiScorez[i]);
          }//end if
          
          else{
            output.println(hiScorez[i]);
            
          }
          
        }//end for
        
        //finalise and close file
        output.flush();
        output.close();
        
        //set gameplayed to false
        gamePlayed = false;
        
      }//end if
 
     
    }//end if 
    
    
  }//end else if
  
}//end draw

//if beginGame menu button is clicked, reset the game
void beginGame(){
  gamePlayed = true;
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

//change gameState to viewControls
void viewControls(){
  gameState=("viewControls");
  
}//end viewControls

//change gamestate to about
void about(){  
  gameState=("aboutGame");
  
}//end about

//function to create the enemies
void createEnemies(){
  for(int i=400;i<900;i+=100){
    for(int j=0;j<400;j+=100){
      ChaosWizard enemy = new ChaosWizard(i, j);
      gameObjects.add(enemy);

    }//end for
    
  }//end for
  
}//end createEnemies

//generate random song when game begins
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

//get menu song (infernus ad astra)
void getInfernusAdAstra(){
  songFile="InfernusAdAstra.mp3";
  
  player.pause();
  player = minim.loadFile(songFile, 2048);
  player.loop();
  
}//end getInfernusAdAstra

//if key is pressed
void keyPressed(){
  keys[keyCode]= true;
  
}//end 

//if keyIsreleased
void keyReleased(){
  keys[keyCode]=false;
  
}//end keyreleased

//function to check if player is killed
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

//check if wizard is died
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
            
            score+=175;
            wizDestroyed+=1;
            
            
          }//end if
          
        }//end if
        
      }//end for
      
    }//end if
    
  }//end for
  
}//end checkWizardDeath

//read in data
void readInData(){
  hiScorez = loadStrings("hiScores.txt");
    
}//end readInData

//set gameHiScores
void hiScores(){
  gameState="hiScores";  
  
}//end hiScores
