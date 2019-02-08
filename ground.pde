class Ground{
  int w;
  int h;
  int x_pos;
  int y_pos;
  
  
  
  Ground(int ix_pos, int iy_pos, int iw, int ih){
   w = iw;
   h = ih;
   x_pos = ix_pos;
   y_pos = iy_pos;
  }
  void display(){
    fill(0,255,0);
    rect(x_pos,y_pos,w,h);
  }
}
