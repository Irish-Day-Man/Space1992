abstract class GameObject{
  PVector pos;
  PVector hitboxNW;
  PVector hitboxSE;
  float objWidth;
  float objHeight;
  float speed;
  
  GameObject(){
    this(width*0.5f, height *0.5f, 0, 0);
    
  }//end constructor
  
  GameObject(float x, float y, float objHeight, float objWidth){
    pos = new PVector(x,y);
    this.objWidth = objWidth;
    this.objHeight = objHeight;
    
    
  }//end constructor
  
  abstract void update();
  abstract void render();
  
}//end class
