class ChaosBolt extends GameObject{
  
  ChaosBolt(){
    
  }//end 
  
  int getObjHeight(){
    return 40; 
    
  }
  int getObjWidth(){
    return 14;
    
  }//end int
  
  void render(){
    
    pushMatrix();
    translate(pos.x,pos.y);
    stroke(156,72,166);
    line(6,0,10,10);
    line(10,10,4,24);
    line(4,24,7,40);
  
    stroke(231,54,54);
    line(10,0,4,12);
    line(4,12,8,22);
    line(8,22,7,40);
  
    stroke(89,231,54);
    line(14,0,7,11);
    line(7,11,6,23);
    line(6,23,7,40);
  
    popMatrix();
  }//end render
  
  void update(){
    pos.y+=5;
    
    if(pos.y+14>820){
      gameObjects.remove(this);
      
    }//end if
    
  }
  
}
