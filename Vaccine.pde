class Vaccine{
  float x;
  float y;
  
  Vaccine(){
    x=width/2;
    y=height/2;
  }
  void set_position(float in_x,float in_y){
    x=in_x;
    y=in_y;
  }
  float get_x(){return x;}
  float get_y(){return y;}
  void display(){
    shapeMode(CENTER);
    shape(svaccine, x, y, 100, 100);
  }
}
