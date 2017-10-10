class PCharacter {

  //Variables
  PVector pos;
  PVector vel;
  PVector accel;
  int mass = 1;
  boolean collision = false;


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
  PVector moveForce = new PVector (0.18, 0); //right 
  PVector negMoveForce = new PVector (-0.18, 0); //left
  PVector grav = new PVector(0, 0.35); //gravity
  float xMax = 2; //Terminal velocity on the x axis
  float errorMarg = 3; //a margin of error for early detection


  //variable set ups
  boolean leftPressed;
  boolean rightPressed;
  int playerH = 25; 
  int playerW = 10;



  public Player(int x, int y) {
    super(x, y);

    leftPressed = false;
    rightPressed = false;
  }


  void applyForce(PVector force) { //force calculations
    if (vel.x >= xMax ) {
      vel.x = xMax;
    } else if (vel.x <= -xMax ) {
      vel.x = -xMax;
    }
    PVector f = PVector.div(force, mass);
    accel.add(f);
  }



  void update() { //Main draw function


    ground = floor;

    //moves the character if pressed
    if (leftPressed) applyForce(negMoveForce); 
    if (rightPressed) applyForce(moveForce);


    if (collision == false) {//checks the player is not haning on an object
      applyForce(grav);
    } else {
      collision = false;
    }

    //friction calculations and application 
    PVector friction = vel.copy();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);
    applyForce(friction);




    if (pos.y > floor-playerH) { //check to stop clipping into the floor
      vel.y = 0; 
      pos.y = floor-playerH;
    }



    super.update();
  }

  void draw() {

    // do extra stuff here
    /* things to do
     - add spirtes 
     */
    rect(pos.x, pos.y, playerW, playerH);
  }

  //This is used for takeDowns
  void collideWithPlayers(ArrayList<PCharacter> chars) {
    for (PCharacter i : chars) {
      if (pos.x > i.pos.x) pos.x = i.pos.x;
    }
  }


  void collideWithObjects(ArrayList<Block> blocks) { //block collision

    for (Block i : blocks) { //Runs though all blocks

      //X detections
      if (pos.x+playerW > i.pos.x) { //left detection
        if (pos.x < i.pos.x+blockW) {  //right detection


          //Y detections
          if (pos.y-2 < i.pos.y+blockH) { //bottom
            if (pos.y+playerH-2 > i.pos.y) { //top


              if (pos.y+playerH-2 < i.pos.y+3) { 
                //this needs work tries to move player if standing on object to object top
                pos.y = i.pos.y-playerH;
                ground = pos.y+playerH; //this is a test variable 
              }

              if (pos.y+playerH-2 > i.pos.y+3) { //this needs work. Tries to move ground to feet of player if standing on objectawwwd
                pos.y=i.pos.y+blockH-1;
              }

              vel.y=0;
              collision = true;
            }
          }
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
    if (pos.y >= ground-playerH) //checks if the player is on the ground allowing to drop
      applyForce(jumpForce);
  }

  void drop() {
    vel.y = 2;
  }
}