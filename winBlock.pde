class WinBlock{
 
 int w;
  int h;
  int x_pos;
  int y_pos;
  color block_c;
  
   WinBlock(int ix_pos, int iy_pos, int iw, int ih){
   w = iw;
   h = ih;
   x_pos = ix_pos;
   y_pos = iy_pos;
   block_c = color(255,255,0);
   
  } 
  
  
   void display(){
    fill(block_c);
    rect(x_pos,y_pos,w,h);
   }
   
  
}
