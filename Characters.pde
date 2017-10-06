class PCharacter {
  PVector pos;
  PVector vel;
  PVector accel;
  int mass = 1;
  
  public PCharacter(int x, int y) {
    pos = new PVector(x,y);
    vel = new PVector(0,0);
    accel = new PVector(0,0);
  }
  
  void draw() {
      
  }
  
  void update() {
    vel.add(accel);
    pos.add(vel);
    accel.mult(0);
  }
  
  void collideWithPlayers(ArrayList<PCharacter> chars) {
    
  }
  
  void collideWithObjects(ArrayList<Block> chars) {
    
  }
  
}


//---------------------------------------------------------------------------//

class Player extends PCharacter { //The player class
  
  //modifyable Variables
  
  float c = 0.15; // friction coefficient
  PVector grav = new PVector(0, -9); //gravity
  PVector moveForce = new PVector (0.15, 0); //right 
  PVector negMoveForce = new PVector (-0.15, 0); //left
  
  
  
  
  
  //variable set ups
  boolean leftPressed;
  boolean rightPressed;
  
  
  
  public Player(int x, int y) {
    super(x, y);
    
    leftPressed = false;
    rightPressed = false;
    
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    accel.add(f);
  }
  
  void update() {
   if (leftPressed) applyForce(negMoveForce); 
   if (rightPressed) applyForce(moveForce);
   
   applyForce(new PVector(0, 0.25));
   
    PVector friction = vel.copy();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);
    
    applyForce(friction);
   
   
   if (pos.y > 500) {
     vel.y = 0;
     pos.y = 500;
   }
   
   super.update();
  }
  
  void draw() {
    
    
    // do extra stuff here
    /* things to do
    - add spirtes 
    */
    rect(pos.x ,pos.y, 10, 25);
    
  }
  
  void collideWithPlayers(ArrayList<PCharacter> chars) {
    for (PCharacter i: chars) {
     if (pos.x > i.pos.x) pos.x = i.pos.x;
    }
  }
  
  void collideWithObjects(ArrayList<Block> blocks) {
     for (Block i: blocks) {
       if (pos.x > i.pos.x) pos.x = i.pos.x;
    }
  }
  
  void moveRight() {
    rightPressed = true;
  }
  
  void moveLeft() {
    leftPressed = true;
  }
  
  void stopRight() {
    rightPressed = false;
  }
  
  void stopLeft() {
    leftPressed = false;
  }
  
  void jump() {
     if (pos.y >= 500)
       applyForce(grav); 
  }
  
  
}