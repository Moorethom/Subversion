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

  float c = 0.12; // friction coefficient
  PVector jumpForce = new PVector(0, -10); //jump
  PVector moveForce = new PVector (0.2, 0); //right 
  PVector negMoveForce = new PVector (-0.2, 0); //left
  PVector grav = new PVector(0, 0.35); //gravity
  float xMax = 3; //Terminal velocity on the x axis
  //float yMax = 10; //Terminal velocity on the y axis 
  boolean topCollision = false; //checks if player is on the top


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
    //Terminal velocity x value
    if (vel.x >= xMax ) { 
      vel.x = xMax;
    } else if (vel.x <= -xMax ) {
      vel.x = -xMax;
    }

    //Terminal velocity y value 
    //if (vel.y >= yMax ) {
    // vel.y = yMax;
    //} else if (vel.y <= -yMax ) {
    //  vel.y = -yMax;
    //}

    //Calulations 
    PVector f = PVector.div(force, mass);
    accel.add(f);
  }



  void update() { //Main draw function
  
    

    //moves the character if pressed
    if (leftPressed) applyForce(negMoveForce); 
    if (rightPressed) applyForce(moveForce);


    if (collision == false) { //checks the player is not hanging on an object
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

    ground = floor; //this resets the players ground position to stop it from jumping when not on an object or floor
    topCollision = false;

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
          if (pos.y < i.pos.y+blockH) { //bottom
            if (pos.y+playerH > i.pos.y) { //top


              if (pos.x+playerW > i.pos.x) { //left side detection
                if (pos.x+playerW < i.pos.x+5) {
                  pos.x = i.pos.x-playerW;
                }
              }
              
              if (pos.x > i.pos.x+blockW-5) { //right side detection
                if (pos.x < i.pos.x+blockW) {
                  pos.x = i.pos.x+blockW;
                }
              }

              if (pos.y+playerH < i.pos.y+(blockH)) { //this checks if the player is on top of an object
                pos.y = i.pos.y-playerH;
                topCollision = true;
              } else if (pos.y > i.pos.y+blockH+(blockH/2)) { //this checks if the player is hanging off the object
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


//--------------------------------------------------------------------------------------------//

//Button presses

  void moveRight() {
    rightPressed = true;
    topCollision = false;
  }

  void moveLeft() {
    leftPressed = true;
    topCollision = false;
  }

  void stopRight() {
    rightPressed = false;
    topCollision = false;
  }

  void stopLeft() {
    leftPressed = false;
    topCollision = false;
  }

  void jump() {
    if (pos.y+playerH >= ground || topCollision == true) //checks if the player is on the ground allowing to drop
      applyForce(jumpForce);
    topCollision = false;
  }

  void drop() {
    vel.y = 3;
  }
}