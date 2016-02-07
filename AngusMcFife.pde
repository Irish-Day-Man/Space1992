class AngusMcFife extends GameObject implements ChangeStat{
  
  char left;
  char right;
  char swing;
  int health;
  
  
  AngusMcFife(char left, char right, char swing, float startX, float startY){
    super(startX, startY,80, 80);
    this.left = left;
    this.right = right;
    this.swing = swing;
    health = 10;
    println(startX, startY);
    
  }//end constructor
  
  int recoveryTime = 9;
  
  int getHealth(){
    return health;  
    
  }
  
  void setHealth(int health){
    this.health = health;
    
  }//end setHealth
  
  public void render(){
    noStroke();
    pushMatrix();
    translate(pos.x,pos.y);
    //armour
    fill(53,249,151);
    rect(10,35,50,35);
    rect(5,40,60,10);
    rect(0,50,70,10);
    
    //astral hammer
    fill(232,124,53);
    rect(65,50,5,-20);
    fill(200,200,200);
    rect(60,30,15,-15);
    
    //hair
    fill(249,252,109);
    rect(20,0,30,40);
    rect(15,5,40,30);
    rect(10,15,50,10); 
    popMatrix();
    
  }
  
  public void update(){
      if(keys[left]){
        if(pos.x>width/3+5){
          pos.x-=5;
            
          
        }//end if
        
        else{
          
        }//end else
        
      }//end if left
      
      if(keys[right]){
        if(pos.x<((width/3)*2)-80){
          pos.x+=5;
          
        }//end if
        
      }//end if
      
      if(keys[swing]&& recoveryTime>60){
        
        AstralHammer hammer = new AstralHammer();
        hammer.pos.x=pos.x;
        hammer.pos.y=pos.y;
        gameObjects.add(hammer);
        recoveryTime=0;
      }//end 
      
      recoveryTime+=1;
      
      
    
  }//end update
  
}
