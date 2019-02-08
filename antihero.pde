class AntiHero {
  int w;
  int h;
  int x_pos;
  int y_pos;
  int speed = 1;
  int jump_speed = 1;
  int jump_high = 50;
  int jump_count = 0;
  int fall_speed = 1;

  boolean fall = true;
  boolean move_left = false;
  boolean move_right = false;
  boolean jump = false;
  boolean right_stop =false;
  boolean left_stop =false;
  boolean up_stop =false;
  boolean down_stop =false;
  boolean x_follow = true;
  boolean overhead_stuck = false;


  int slow=0;
  int slow_level=1;
  boolean overhead_dir = false;
  int avoid_jump_count=0;
  int max_avoid_jump_count=30;


  color hero_c;

  AntiHero(int ix_pos, int iy_pos, int iw, int ih, color ihero_c) {
    w = iw;
    h = ih;
    x_pos = ix_pos;
    y_pos = iy_pos;
    hero_c = ihero_c;
  }

  void mleft() {
    move_left = true; 
    move_right = false;
  }

  void mright() {
    move_left = false; 
    move_right = true;
  }

  void xFollow(int xt) {
    if (xt<x_pos && !left_stop) {
      mleft();
    }

    if (xt>x_pos && !right_stop) {
      mright();
    }
  }

  void yFollow(int yt) {
    if (!up_stop) {
      if (yt<y_pos)jump=true;
      //println("y_follow");
    }
  }



  void avoid(int xt, int yt, int wt, int ht) {

    //print("right_stop_avoid ");
    //println(right_stop);

    //print("left_stop avoid ");
    //println(left_stop);

    //print("up_stop avoid ");
    //println(up_stop);

    //print("down_stop avoid ");
    //println(down_stop);
    
    if (right_stop || left_stop) {
      left_stop=false;
      right_stop=false;
      if(!up_stop && down_stop){
      avoid_jump_count++;
      if(avoid_jump_count>max_avoid_jump_count){
      jump=true;
      avoid_jump_count=0;
      println("avoid jump");
      }
      }
    }

    if (down_stop && x_pos>xt-w && x_pos<xt+wt ) {
      overhead_stuck = true;
    }

    if (down_stop || up_stop) {
      up_stop=false;
      down_stop=false;
    }
  }

  void follow(int xt, int yt, int wt, int ht) {


    if (!overhead_stuck) {
      xFollow(xt);
    } else {
      if (overhead_dir) {
        move_right=true;
        move_left=false;
      } else {
        move_right=false;
        move_left=true;
      }
      if (!down_stop)overhead_stuck=false;
    }




    yFollow(yt);
    avoid(xt, yt, wt, ht);
  }


  boolean intersect( int x2, int y2, int w2, int h2) {
    if (x_pos>x2-w && x_pos<x2+w2 && y_pos+h>=y2 && y_pos<=y2+h2) {
      return true;
    } else return false;
  }






  void intersectStop(Ground ground ) {
    int x2 = ground.x_pos;
    int y2 = ground.y_pos;
    int w2 = ground.w;
    int h2 = ground.h;

    if (x_pos+w>x2 && x_pos<x2+w2 && y_pos+h>y2 && y_pos<y2+h2) {

           



      if (y_pos+h<=y2+fall_speed ) {
        fall = false; 
        y_pos = y2-h;
        down_stop=true;
        println("down_stop");
      }
      if (y_pos>=y2+h2-jump_speed) {
        jump=false;
        jump_count = 0;
        fall=true;
        y_pos = y2+h2;
        up_stop=true;
        println("up_stop");
        //y
      }
      
      
       if ( x_pos+w<=x2+speed ) {
        move_right=false;
        right_stop = true;
        x_pos=x2-w;
        println("rightstop");
      }

      if (x_pos>=x2+w2-speed) {
        move_left=false; 
        x_pos=x2+w2;
        left_stop = true;
        println("leftstop");
      }

      //
    } else {
      fall = true; 
      //left_stop=false;
      //right_stop=false;
    }
  }

  void display() {
    fill(hero_c);
    rect(x_pos, y_pos, w, h);
    if (slow==slow_level) {

      slow=0;

      if (move_left)x_pos-=speed;
      if (move_right)x_pos+=speed;
      if (jump) {
        fall=false;
        y_pos-=fall_speed;
        jump_count++;
        if (jump_count>jump_high) {
          jump = false;
          fall=true;
          jump_count=0;
        }
      }
      if (fall)y_pos+=fall_speed;
      if (x_pos>640)x_pos=0;
      if (x_pos+w<0)x_pos=640;
    }
    slow++;
  }
}
