class AstralHammer extends GameObject{
  
  int objHeight = 20; 
  int objWidth = 20;
  
  AstralHammer(){
    
  }//end AstralHammer
  
  public void render(){
    pushMatrix();
    translate(pos.x,pos.y);
    noStroke();
    fill(232,124,53);
    rect(5,20,5,20);
    fill(200,200,200);
    rect(0,0,15,20);
    popMatrix();
    
  }//end render
  
  public void update(){
    pos.y-=8;
    if(pos.y<0){
      gameObjects.remove(this);
      
    }//end if
    
  }//end uodate
  
}//end class
