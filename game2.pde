
Hero myHero;
WinBlock myWinBlock;
AntiHero[] myAntiHero;
Ground Floor;
Ground[] block;

int scr_w = 640;
int scr_h = 480;
int block_count = 100;

int[] block_x=new int[scr_w/20];
int[] block_y=new int[scr_h/20];
int co=0;

color myHero_c = color(255,0,0);
color myAntiHero_c = color(0,0,255);
int enemy_count =0;
boolean start=true;
int kill_del=500;

void Init(){


  
   myHero = new Hero(block_x[int(random(0, scr_w/20))],block_y[int(random(0, scr_h/20))],19,19,myHero_c);
   myWinBlock = new WinBlock(block_x[int(random(0, scr_w/20))],block_y[int(random(0, scr_h/20))],20,20);
   myAntiHero = new AntiHero[enemy_count];
   
   
   Floor= new Ground(0,480-20,scr_w+20,20);
   block= new Ground[block_count];
 
 for(int i = 0 ; i<enemy_count; i++){
     myAntiHero[i] = new AntiHero(block_x[int(random(0, scr_w/20))],block_y[int(random(0, scr_h/20))],19,19,myAntiHero_c);
   } 
 
    for(int i = 0 ; i<block_count; i++){
     block[i] =  new Ground(block_x[int(random(0, scr_w/20))],block_y[int(random(0, (scr_h-20)/20))],20,20);
   } 
  
  
}


void Grid(){
    
      for (int i =0;i<scr_w/20;i++){
    block_x[i]=co;
    co+=20;
  }

  co = 0;


  for (int i =0;i<(scr_h-20)/20;i++){
    print(i);
    block_y[i]=co;
    co+=20;
  } 
}

void setup(){
   size(640,480);
   Grid();

  
  
  
  Init();
 
}





void draw(){
 background(0); 
 myHero.display();

 Floor.display();
 
 for(int i = 0 ; i<enemy_count; i++){
 myAntiHero[i].display();
 }

  for(int i = 0 ; i<block_count; i++){
  block[i].display();
  //rect(0,0,20,20);
 }
  myWinBlock.display();

 myHero.intersectStop(Floor );
 for(int i = 0 ; i<enemy_count; i++){
 myAntiHero[i].intersectStop(Floor );
 }
   for(int i = 0 ; i<block_count; i++){
  myHero.intersectStop(block[i]);
  for(int z = 0 ; z<enemy_count; z++){
  myAntiHero[z].intersectStop(block[i]);
  }
  
 }
 for(int i = 0 ; i<enemy_count; i++){
 myAntiHero[i].follow(myHero.x_pos,myHero.y_pos,myHero.w,myHero.h);
 }
 for(int i = 0 ; i<enemy_count; i++){
 if(myAntiHero[i].intersect(myHero.x_pos,myHero.y_pos,myHero.w,myHero.h)){enemy_count=1;delay(kill_del);Init();start=true;}
 }
  if(myHero.intersect(myWinBlock.x_pos,myWinBlock.y_pos,myWinBlock.w,myWinBlock.h)){enemy_count++;delay(kill_del);Init();start=true;}

//if(start){delay(1000);start=false;}
}

void keyPressed(){
 myHero.KP(); 
 
}
void keyReleased(){
  myHero.KR();
}
