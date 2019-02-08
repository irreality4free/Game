class Hero{
  int w;
  int h;
  int x_pos;
  int y_pos;
  int speed = 2;
  int jump_speed = 2;
  int jump_high = 50;
  int jump_count = 0;
  int fall_speed = 2;
  
  boolean fall = true;
  boolean move_left = false;
  boolean move_right = false;
  boolean jump = false;
  
  
  color hero_c;
  
  Hero(int ix_pos, int iy_pos, int iw, int ih,color ihero_c){
   w = iw;
   h = ih;
   x_pos = ix_pos;
   y_pos = iy_pos;
   hero_c = ihero_c;
   
  }
  
  void KP(){

    if(keyCode == 37)move_left = true;
    if(keyCode == 39)move_right = true;
    if(keyCode == 38)jump = true;
    
  }
  
  void KR(){
    if(keyCode == 37)move_left = false;
    if(keyCode == 39)move_right = false;
  }
  
  
  boolean intersect( int x2, int y2, int w2, int h2){
  if(x_pos>x2-w && x_pos<x2+w2 && y_pos+h>=y2 && y_pos<=y2+h2){
      return true;
  }
  else return false;
    
}






  void intersectStop(Ground ground ){
    int x2 = ground.x_pos;
    int y2 = ground.y_pos;
    int w2 = ground.w;
    int h2 = ground.h;
    
  if(x_pos+w>x2 && x_pos<x2+w2 && y_pos+h>y2 && y_pos<y2+h2){
    
    if(y_pos+h<=y2+fall_speed){
     fall = false; 
     y_pos = y2-h;


    }
    if(y_pos>=y2+h2-jump_speed){
      jump=false;
      jump_count = 0;
      fall=true;
      y_pos = y2+h2;
      
      //y
    }
    if(x_pos+w<=x2+speed){
      move_right=false;
      
      x_pos=x2-w;
      

    }
    
      if(x_pos>=x2+w2-speed){
      move_left=false; 
      x_pos=x2+w2;
    }
    
    
  }
  else{
   fall = true; 
  }
  

}
  
  void display(){
    fill(hero_c);
    rect(x_pos,y_pos,w,h);
    if(move_left)x_pos-=speed;
    if(move_right)x_pos+=speed;
    if(jump){
     fall=false;
     y_pos-=fall_speed;
     jump_count++;
     if(jump_count>jump_high){
       jump = false;
       fall=true;
       jump_count=0;
     }
    }
    if(fall)y_pos+=fall_speed;
    if(x_pos>640)x_pos=0;
    if(x_pos+w<0)x_pos=640;
    
  }
  
}
