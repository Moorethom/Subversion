class PCharacter {
  PVector pos;
  PVector vel;
  PVector accel;
  int mass = 1;


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

  float c = 0.10; // friction coefficient
  PVector jumpForce = new PVector(0, -10); //jump
  PVector moveForce = new PVector (0.1, 0); //right 
  PVector negMoveForce = new PVector (-0.1, 0); //left
  PVector grav = new PVector(0, 0.35);





  //variable set ups
  boolean leftPressed;
  boolean rightPressed;



  public Player(int x, int y) {
    super(x, y);

    leftPressed = false;
    rightPressed = false;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    accel.add(f);
  }

  void update() {
    if (leftPressed) applyForce(negMoveForce); 
    if (rightPressed) applyForce(moveForce);

    applyForce(grav);

    PVector friction = vel.copy();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);

    applyForce(friction);


    if (pos.y > ground-25) {
      vel.y = 0;
      pos.y = ground-25;
    }

    super.update();
  }

  void draw() {


    // do extra stuff here
    /* things to do
     - add spirtes 
     */
    rect(pos.x, pos.y, 10, 25);
  }

  void collideWithPlayers(ArrayList<PCharacter> chars) {
    for (PCharacter i : chars) {
      if (pos.x > i.pos.x) pos.x = i.pos.x;
    }
  }

  void collideWithObjects(ArrayList<Block> blocks) {
    for (Block i : blocks) {
      if (vel.x + 25 >= i.pos.x
        && vel.y + 25 >= i.pos.y
        && vel.x - 25 <= i.pos.x + 25
        && vel.y - 25 <= i.pos.y + 25) {
        float overlap_x, overlap_y;

        // determine overlap based on what side the boid is on the object
        if (vel.x + 25 < i.pos.x + (25/2)) overlap_x = i.pos.x-this.vel.x-25;
        else overlap_x = abs((i.pos.x+25)-this.vel.x+25);

        // do same for y. 
        if (vel.y + 25 < i.pos.y + (25/2)) overlap_y = i.pos.y - this.vel.y-25;
        else overlap_y = abs((i.pos.y+25)-this.vel.y+25);

        if (abs(overlap_y) < abs(overlap_x)) pos.y += overlap_y;
        else pos.x += overlap_x;
      }
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
    if (pos.y >= ground-25)
      applyForce(jumpForce);
  }
}