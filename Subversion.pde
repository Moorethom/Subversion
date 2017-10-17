// constants
color BACKGROUND_COLOUR = color(255, 255, 255);

PImage pStanding;
PImage pFalling;
PImage pJumping;
PImage pBJumping;
PImage pBFalling;
PImage pHanging;

Animation gWalking;
Animation gBWalking;
Animation pSwinging;
Animation pBSwinging;
Animation pRunning;
Animation pBRunning;



public int playerCount = 0;
public int currentLevel = 0;
public int playersInWorld = 0;

public int time;




//sets up classes
Player player;
Guard guard;

World world;
HUD hud;


void setup() {
  size(1366, 768, P2D);
  background(BACKGROUND_COLOUR);
  player = new Player(30, floor+25);
  world = new World();
  hud = new HUD();

  time = millis();


  //world 
  world.charactersInWorld.add(player);


  //sprites
  pStanding = loadImage("pStanding.png");
  pFalling = loadImage("pFalling.png");
  pJumping = loadImage("pJumping.png");
  pBJumping = loadImage("pBJumping.png");
  pBFalling = loadImage("pBFalling.png");
  pHanging = loadImage("l0_pHanging_01.png");
  
  gWalking = new Animation("l0_gWalking", 50);
  gBWalking = new Animation("l0_gBWalking", 50);
  pRunning = new Animation("l0_pRunning", 47);
  pBRunning = new Animation("pBRunning", 46);
  pSwinging = new Animation("l0_pHanging", 70);
  pBSwinging = new Animation("l0_pBHanging", 70);
}


void draw() {
  background(BACKGROUND_COLOUR);
  world.update();
  world.draw();
  hud.draw();
}

//------------------------------------------------------------------------------------------//


//Key functions

void keyPressed() {
  if (key == 'd') {
    player.moveRight();
  } else if (key == 'a') {
    player.moveLeft();
  } else if (key == 'w') {
    player.raise();
    player.jump();
    //player.climb();
  }
}

void keyReleased() {
  if (key == 'd')
  {
    player.stopRight();
  }
  if (key == 'a')
  {
    player.stopLeft();
  }

  if (key == 's') {
    player.drop();
    player.fall();
  }

  if (key == ' ') {
    world.openD();
  }
}