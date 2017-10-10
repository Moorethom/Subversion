// constants
color BACKGROUND_COLOUR = color(255,255,255);





//sets up classes
Player player;
World world;
HUD hud;


void setup() {
  size(1000, 600);
  background(BACKGROUND_COLOUR);
  player = new Player(100, 400);
  world = new World();
  hud = new HUD();
  
  //world 
  world.charactersInWorld.add(player);
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
    player.jump();
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
  
  if (key == 's'){
    player.drop();
  }
}