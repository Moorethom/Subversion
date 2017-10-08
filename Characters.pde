class PCharacter {

  //Variables
  PVector pos;
  PVector vel;
  PVector accel;
  int mass = 1;
  int playerH = 25;
  int playerW = 10;

  //temp
  int blockH = 30;
  int blockW = 30;

  public PCharacter(int x, int y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    accel = new PVector(0, 0);
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
  PVector jumpForce = new PVector(0, -10); //jump
  PVector moveForce = new PVector (0.2, 0); //right 
  PVector negMoveForce = new PVector (-0.2, 0); //left
  PVector grav = new PVector(0, 0.35);



  //variable set ups
  boolean leftPressed;
  boolean rightPressed;



  public Player(int x, int y) {
    super(x, y);

    leftPressed = false;
    rightPressed = false;
  }


  void applyForce(PVector force) { //force calculations
    PVector f = PVector.div(force, mass);
    accel.add(f);
  }



  void update() { //Main draw function

    //moves the character
    if (leftPressed) applyForce(negMoveForce); 
    if (rightPressed) applyForce(moveForce);

    if (vel.x >= 3 ) {
      vel.x = 3;
    } else if (vel.x <= -3 ) {
      vel.x = -3;
    }
    applyForce(grav); 


    //friction calculations
    PVector friction = vel.copy();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);

    applyForce(friction);

    //check for clipping into the ground
    if (pos.y > ground-playerH) {
      vel.y = 0;
      pos.y = ground-playerH;
    }

    super.update();
  }

  void draw() {


    // do extra stuff here
    /* things to do
     - add spirtes 
     */
    rect(pos.x, pos.y, 10, playerH);
  }

  //This is used for takeDowns
  void collideWithPlayers(ArrayList<PCharacter> chars) {
    for (PCharacter i : chars) {
      if (pos.x > i.pos.x) pos.x = i.pos.x;
    }
  }

  //object collsion
  void collideWithObjects(ArrayList<Block> blocks) {
    for (Block i : blocks) {
      if (pos.x >= i.pos.x && pos.x <= i.pos.x + blockW) { //top check
      println("wtf");
        if (pos.y >= i.pos.y && pos.y <= i.pos.y +blockH) {
          println("hi");
          vel.x = 0;
        }
      }
    }
  }






  //Button presses
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
    if (pos.y >= ground-playerH)
      applyForce(jumpForce);
  }
}