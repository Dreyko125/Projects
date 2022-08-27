PShape srona,svaccine,sbackground,smd1,smd2,smd3,sendgame;  
    //.svg images downloaded for this sketch 
    //PImage gia pngs tha douleve komple
int i,LEVELS,N=1,ALIVE=1;  
float SPEED;
   //N: how many cases of Covid in level 1 
   //ALIVE: how many cases of Covid currently alive
   //DIFFICULTY: EASY=4 LEVELS=1X SPEED
               //NORMAL=5 LEVELS=1X SPEED
               //HARD=5 LEVELS=2X SPEED
   //LEVELS: how many stages left (depends on the difficulty)
   //SPEED: how fast the virus floats (depends on the difficulty)
boolean flag=true,END=false;  
  //true= draw(): gives information to the player until he does something (we will see)
  //false= draw(): resumes the game
  //END: flag to show the end of the game
Corona[] virus = new Corona[16];  //At the last level (5) there will be 16 cases
                              //so 16 is the maximum size of the array that we will need
Vaccine pfizer;  //vaccine: our mouse

void setup(){
  size(1024,768);
  
  srona=loadShape("rona.svg");
  svaccine=loadShape("vaccine.svg");
  sbackground=loadShape("B.svg");
  smd1=loadShape("EASY.svg");
  smd2=loadShape("NORMAL.svg");
  smd3=loadShape("HARD.svg");
  sendgame=loadShape("ENDGAME.svg");
  
  pfizer=new Vaccine();  //starting with 1 vaccine
  virus[0]=new Corona();  //and 1 covid case
}

void draw(){
  if(flag){
    if(END){   //END OF GAME MESSAGE SHOWN
      shapeMode(CENTER);
      shape(sendgame,width/2,height/3,width+width/5,height);
    }
    else{    //OPENING GAME MENU (choose a mode)
      shapeMode(CENTER);
      shape(sbackground,width/2,height/2);
      shape(smd1,width/2,height/6,350,100);
      shape(smd2,width/2,height/3,480,175);
      shape(smd3,width/2,height/1.8,430,150);  
      pfizer.display();
      pfizer.set_position(mouseX,mouseY);
    }  
  }
  else{    //PLAYING THE GAME
    shape(sbackground,width/2,height/2);
    pfizer.display();
    for(i=0;i<N;i++){
      if(virus[i] != null){ //don't display the "dead" ones
        virus[i].display();
        virus[i].floating();
      }
    }
    pfizer.set_position(mouseX,mouseY);
  }
}

void mousePressed(){
  if(flag){  //we are waiting for the player to move on
    if(pfizer.get_x() >= (width/2)-200 && pfizer.get_x() <= (width/2)+200){
      if(pfizer.get_y() >= (height/6) && pfizer.get_y() <= (height/6)+80){  
        //^^^^ abs sunarthsh tha douleve komple full
        //CLICKED ON EASY
        LEVELS=3;
        SPEED=1;
        flag=false;
        sbackground=loadShape("A.svg");
      }
      else if(pfizer.get_y() >= (height/3)+50 && pfizer.get_y() <= (height/3)+110){
        //CLICKED ON NORMAL
        LEVELS=4;
        SPEED=1.5;
        flag=false;
        sbackground=loadShape("C.svg");        
      }
      else if(pfizer.get_y() >= (height/1.8)+50 && pfizer.get_y() <= (height/1.8)+110){
        //CLICKED ON HARD
        LEVELS=4;
        SPEED=2;
        flag=false;
        sbackground=loadShape("E.svg");
      }
    }  
  }
  else{    //we are playing the game!
    for(i=0;i<N;i++){  //if we click on the virus we are cured!
      if(virus[i] != null){
        if(pfizer.get_x() >= (virus[i].get_x()-100) && pfizer.get_x() <= (virus[i].get_x()+10)){
          if(pfizer.get_y() >= (virus[i].get_y()-10) && pfizer.get_y() <= (virus[i].get_y()+100)){
            virus[i]=null;
            ALIVE--;
            break;  //1 mousePress = 1 Kill so we move on 
          }
        }
      }
    }
    if(ALIVE==0){  //Won this level, on to the next!!
      if(LEVELS==0){  // If no levels are left the game ends
        flag=true;
        END=true;
      }
      else{
        LEVELS--;  // One more level cleared
        N=N*2;    // Next level the virus cases are doubled
        ALIVE=N;  // Updating the ALIVE counter
        for(i=0;i<N;i++){
          virus[i]=new Corona();
        }
      }    
    }
  }
}
