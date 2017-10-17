// constants
color BACKGROUND_COLOUR = color(255, 255, 255);
PImage pStanding;
Animation gWalking;
Animation gBWalking;
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
  gWalking = new Animation("l0_gWalking", 50);
  gBWalking = new Animation("l0_gBWalking", 50);
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