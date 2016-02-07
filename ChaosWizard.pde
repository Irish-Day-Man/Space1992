class ChaosWizard extends GameObject{
  
  //ArrayList<ChaosWizard> forceOfZargothrax = new ArrayList<ChaosWizard>();
 
  ChaosWizard(float startX, float startY){
    super(startX, startY,80,80);
    //forceOfZargothrax.add(this);
    
  }//end constructor
  
  void render(){
    noStroke();
    pushMatrix();
    translate(pos.x,pos.y);
    //skin colour
    fill(255,165,66);
    //left cheek section
    rect(20,10,15,10);
    //forehead
    rect(25,0,30,15);
    //right cheek section
    rect(50,10,10,10);
    //nasal / mouth section place later
    rect(30,15,20,10);
    
    fill(255);
    //eyebrows
    //left 1
    rect(30,5,5,5);
    //left 2
    rect(35,10,5,5);
    //right
    rect(45,5,5,5);
    rect(40,10,5,5);
    
    //gown
    fill(22,142,0);
    rect(20,20,40,60);
    
    //right arm segments
    rect(15,25,5,40);
    rect(10,30,5,40);
    
    //left arm segments
    rect(60,25,5,40);
    rect(65,30,5,40);
    
    //right arm trim
    fill(93,1,142);
    rect(5,35,5,30);
    
    //right inner trim
    rect(20,50,5,20);
    
    //left arm trim
    rect(70,35,5,30);
    
    //right inner trim
    rect(55,50,5,20);
    
    //wizards beard
    fill(255);
    rect(25,20,30,15);
    rect(20,25,40,10);
    rect(30,35,20,15);
    rect(35,50,10,5);
    rect(20,25,5,15);
    rect(15,30,5,10);
    rect(55,25,5,15);
    rect(60,30,5,10);
    
    //right hand
    fill(255,165,66);
    rect(0,40,5,15);
    
    //left hand
    rect(75,40,5,15);
    
    //feet
    rect(25,75,10,5);
    rect(45,75,10,5);
    
    //skin colour
    fill(255,165,66);
    //nasal / mouth section place later
    rect(30,15,20,10);
    
    //eyes
    fill(0);
    //left eye
    rect(30,10,5,10);
    //right eye
    rect(45,10,5,10);
    
    //mouth
    rect(30,30,20,5);
    popMatrix();
    
  }//end render
  
  void update(){
    
    if(pos.x<100){
      movementDir=("r");
      enemyOnEdge = true;
      
    }//end if
    
    if(pos.x>width-200){
      movementDir=("l");
      enemyOnEdge = true;
      
    }//end if    
  
    if(frameCount %30 ==0){
      
      if(movementDir.matches("r")){
        pos.x += 100;
        
      }//end if
      
      else{
        pos.x-=100;
      }//end else
      
      int strikeChance = int(random(1,30));
      if(strikeChance == 2){
        
        ChaosBolt chaosLightning = new ChaosBolt();
        chaosLightning.pos.x=pos.x;
        chaosLightning.pos.y=pos.y;
        gameObjects.add(chaosLightning);
        
      }//end if
      
      if(!(frameCount<120)){
        
        if(enemyOnEdge==true){
          pos.y += 50;
          if(pos.y>650){
            gameState = "gameover";
            
          }//end if
          
        }//end enemyOnEdge
      }//end if
      
      
    }//end if
    
  }//end update
  
  
}//end class
