class Corona{
  float x,y;
  float xspeed,yspeed;
  
  Corona(){ 
    x=random(width-width/4);
    y=random(height-height/4);
    if(int(random(2))==0)     //random(2) will return 0 or 1
      xspeed=-1*SPEED;         //so there are 4 options:
    else                        //a) the virus will float up and right
      xspeed=SPEED;                //b) up and left
    if(int(random(2))==0)          //c) down and right
      yspeed=-1*SPEED;              //d) down and left
    else                     //with a speed of SPEED pixels per float (depends on difficulty)
      yspeed=SPEED; 
  }
  void set_position(float in_x,float in_y){
    x=in_x;
    y=in_y;
  }
  void floating(){
    if(x >= width || x <= 0)
      xspeed=-1*xspeed;  //change direction
    if(y >= height || y <= 0)
      yspeed=-1*yspeed;  //change direction
    set_position(x + xspeed, y + yspeed);
  }
  float get_x(){return x;}
  float get_y(){return y;} 
  void display(){
    shapeMode(CENTER);
    shape(srona, x, y, 300, 200);
  }
}
