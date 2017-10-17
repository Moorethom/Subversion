class PCharacter {

  //Variables
  PVector pos;
  PVector vel;
  PVector accel;
  float mass = 1;
  boolean collision = false;


  int playerH = 42; 
  int playerW = 15;


  //THis finds the block type
  // 0 - Concrete floor block
  // 1 - Wall type
  int blockType = 0;

  int countBlock;


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
    if (pos.x<=0) {
      pos.x=0;
    } 
    if (pos.x>10000) {
      pos.x = 50000;
    } else if (pos.x>=1366) {
      pos.x=1366;
    }
    accel.mult(0);
  }

  void collideWithPlayers(ArrayList<PCharacter> chars) {
  }

  void collideWithObjects(ArrayList<Block> chars) {
  }

  void guardKilled() {
  }

  int checkForDoor(ArrayList<Block> blocks) {
    return 0;
  }
}


//---------------------------------------------------------------------------//

class Player extends PCharacter { //The player class

  //modifyable Variables

  float c = 0.19; // friction coefficient
  PVector jumpForce = new PVector(0, -15); //jump
  PVector moveForce = new PVector (0.28, 0); //right 
  PVector negMoveForce = new PVector (-0.28, 0); //left
  PVector grav = new PVector(0, 0.45); //gravity
  float xMax = 4.5; //Terminal velocity on the x axis
  float yMax = 15; //Terminal velocity on the y axis 
  boolean topCollision = false; //checks if player is on the top
  boolean botCollision = false;
  boolean rightCollision = false;
  boolean leftCollision = false;

  //variable set ups
  boolean leftPressed;
  boolean rightPressed;




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
    if (vel.y >= yMax ) {
      vel.y = yMax;
    } else if (vel.y <= -yMax ) {
      vel.y = -yMax;
    }

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
    botCollision = false;

    super.update();
  }

  void draw() {

    // do extra stuff here
    //image(pStanding, pos.x, pos.y);
    rect(pos.x, pos.y, playerW, playerH);
  }

  //This is used for takeDowns
  void collideWithPlayers(ArrayList<PCharacter> chars) {
    playerCount = 0;
    for (PCharacter i : chars) {
      if (playerCount == 0) {
        playerCount++;
      } else {
        if (pos.x+playerW >= i.pos.x) { //left detection
          if (pos.x <= i.pos.x+playerW) {  //right detection

            //Y detections
            if (pos.y <= i.pos.y+playerH) { //bottom
              if (pos.y+playerH >= i.pos.y-(playerH)) { //top


                world.killCharacter(playerCount);
              }
            }
          }
        }
      }
      playerCount++;
    }
  }




  void collideWithObjects(ArrayList<Block> blocks) { //block collision

    for (Block i : blocks) { //Runs though all blocks

      blockType = i.getBlock();
      if (blockType == 0) {
        blockH = 10;
        blockW = floorW;
      } else if (blockType == 1) {
        blockH = 150;
        blockW = 10;
      } else if (blockType == 2) {
        blockH = 100;
        blockW = 10;
      } else if (blockType == 3) {
        blockH = 50;
        blockW = 8;
      } else {
        blockH = 0;
        blockW = 0;
      }


      //X detections
      if (pos.x+playerW >= i.pos.x) { //left detection
        if (pos.x <= i.pos.x+blockW) {  //right detection


          //Y detections
          if (pos.y <= i.pos.y+blockH+2) { //bottom
            if (pos.y+playerH >= i.pos.y) { //top

              botCollision = false;
              topCollision = false;
              rightCollision = false;
              leftCollision = false;


              if (blockType == 0) { //if it is a floor
                if (pos.y+playerH >= i.pos.y+(blockH+2)) { //this checks if the player is hanging off the object
                  pos.y=i.pos.y+blockH-1;
                  botCollision = true;
                } else if (pos.y <= i.pos.y+blockH) { //this checks if the player is on top of an object
                  pos.y = i.pos.y-playerH;
                  topCollision = true;
                }

                collision = true;
                vel.y=0;
              } else if (blockType == 1 || blockType == 2 || blockType == 3) { //if it is a wall
                if (pos.x+playerW >= i.pos.x) { //left side detection
                  if (pos.x+playerW <= i.pos.x+blockW) {
                    pos.x = i.pos.x-playerW;
                    leftCollision = true;
                  }
                } 
                if (pos.x <= i.pos.x+blockW) { //right side detection
                  if (pos.x >= i.pos.x-blockW/2) {
                    pos.x = i.pos.x+blockW;
                    rightCollision = true;
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  int checkForDoor(ArrayList<Block> blocks) {
    countBlock =0;
    for (Block i : blocks) { //Runs though all blocks
      countBlock++;
      if (blockType == 3 || blockType == 4) {
        blockH = 50;
        blockW = 8;


        if (pos.x+playerW >= i.pos.x-45) { //left detection
          if (pos.x <= i.pos.x+blockW+45) {  //right detection


            //Y detections
            if (pos.y <= i.pos.y+blockH+15) { //bottom
              if (pos.y+playerH >= i.pos.y-15) { //top
                return countBlock;
              }
            }
          }
        }
      }
    }
    return 0;
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
  }

  void stopLeft() {
    leftPressed = false;
  }

  void jump() {
    if (pos.y+playerH >= ground || topCollision == true || leftCollision == true || rightCollision == true) //checks if the player is on the ground allowing to drop
      applyForce(jumpForce);
    topCollision = false;
    leftCollision = false;
    rightCollision = false;
  }

  void drop() {
    if (botCollision == true) {
      vel.y = 3;
      topCollision = false;
      botCollision = false;
    }
  }
}

//--------------------------------------------------------------------------------------------//


class Guard extends PCharacter { 

  float c = 0.19; // friction coefficient
  PVector jumpForce = new PVector(0, -14); //jump
  PVector moveForce = new PVector (0.28, 0); //right 
  PVector negMoveForce = new PVector (-0.28, 0); //left
  PVector grav = new PVector(0, 0.45); //gravity
  float xMax = 1; //Terminal velocity on the x axis
  //float yMax = 10; //Terminal velocity on the y axis 
  boolean topCollision = false; //checks if player is on the top
  boolean botCollision = false;
  boolean rightCollision = false;
  boolean leftCollision = false;
  boolean moveL = false;
  boolean detection = false;




  public Guard(int x, int y) {
    super(x, y);
  }

  void draw() {
    // do extra stuff here
    //image(pStanding, pos.x, pos.y);
    rect(pos.x, pos.y, playerW, playerH);
  }




  void applyForce(PVector force) { //force calculations
    //Terminal velocity x value
    if (vel.x >= xMax ) { 
      vel.x = xMax;
    } else if (vel.x <= -xMax ) {
      vel.x = -xMax;
    }

    //Calulations 
    PVector f = PVector.div(force, mass);
    accel.add(f);
  }

  boolean checkCol() {
    double distance = Math.sqrt(Math.pow(pos.x - player.pos.x, 2)+Math.pow(pos.y-player.pos.y, 2));
    println(distance);
    double m = (pos.y-player.pos.y)/(pos.x - player.pos.x);
    double c = player.pos.y-m*player.pos.x;

    int x = (int) player.pos.x;
    int y = (int) player.pos.y;
    
    ellipse(x,y,1,1);
    x += 1;
    double yi = m*x+c;
    y = round((float)yi);
    return false;
  }



  void update() { //Main draw function


    if (collision == false) {  //checks the player is not hanging on an object
      applyForce(grav);
    } else {
      collision = false;
    }

    //calulation for guards detections
    detection = checkCol();


    //friction calculations and application 
    PVector friction = vel.copy();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);
    applyForce(friction);

    //checks player direction
    if (moveL == true) {
      applyForce(moveForce);
    } else {
      applyForce(negMoveForce);
    }


    if (pos.y >= floor-playerH) { //check to stop clipping into the floor
      vel.y = 0; 
      pos.y = floor-playerH;
    }

    ground = floor; //this resets the players ground position to stop it from jumping when not on an object or floor
    botCollision = false;

    super.update();
  }


  void guardKilled() {
    pos.x = 50000;
  }



  void collideWithObjects(ArrayList<Block> blocks) { //block collision

    for (Block i : blocks) { //Runs though all blocks

      blockType = i.getBlock();
      if (blockType == 0) {
        blockH = 10;
        blockW = floorW;
      } else if (blockType == 1) {
        blockH = 150;
        blockW = 10;
      } else if (blockType == 2) {
        blockH = 100;
        blockW = 10;
      } else if (blockType == 3) {
        blockH = 50;
        blockW = 8;
      } else {
        blockH = 0;
        blockW = 0;
      }


      //X detections
      if (pos.x+playerW >= i.pos.x) { //left detection
        if (pos.x <= i.pos.x+blockW) {  //right detection


          //Y detections
          if (pos.y <= i.pos.y+blockH+2) { //bottom
            if (pos.y+playerH >= i.pos.y) { //top

              botCollision = false;
              topCollision = false;
              rightCollision = false;
              leftCollision = false;
              if (blockType == 0) { //if it is a floor
                if (pos.y+playerH >= i.pos.y+(blockH+2)) { //this checks if the player is hanging off the object
                  pos.y=i.pos.y+blockH-1;
                  botCollision = true;
                } else if (pos.y <= i.pos.y+blockH) { //this checks if the player is on top of an object
                  pos.y = i.pos.y-playerH;
                  topCollision = true;
                }
              }


              collision = true;
              if (blockType == 1 || blockType == 2 || blockType == 3) { //if it is a wall
                if (pos.x+playerW >= i.pos.x) { //left side detection
                  if (pos.x+playerW <= i.pos.x+blockW) {
                    pos.x = i.pos.x-playerW;
                    leftCollision = true;
                  }
                } 
                if (pos.x <= i.pos.x+blockW) { //right side detection
                  if (pos.x >= i.pos.x-blockW/2) {
                    pos.x = i.pos.x+blockW;
                    rightCollision = true;
                  }
                }
              }
              if (pos.x+playerW >= i.pos.x) {
                moveL = false;
              } 
              if (pos.x >= i.pos.x+blockW) {
                moveL = true;
              }
            }
          }
        }
      }
    }
  }
}