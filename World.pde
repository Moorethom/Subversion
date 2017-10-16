float ground; //ground height of the world
int floor = 750;
int blockH = 10;
int blockW = 120;
int tempCount = 0;


class World {
  ArrayList<Block> currentWorld;
  ArrayList<PCharacter> charactersInWorld;


  public World() {
    currentWorld = loadLevel(0);
    charactersInWorld = new ArrayList();
  }

  void update() {

    for (PCharacter character : charactersInWorld) {
      character.update();
      character.collideWithPlayers(charactersInWorld);
      character.collideWithObjects(currentWorld);
    }
    line(0, floor, width, floor);
  }

  void draw() {
    for (Block block : currentWorld) {
      block.draw();
    }

    for (PCharacter character : charactersInWorld) {
      character.draw();
    }
  }

  void generateWorld() {
  }

  void killCharacter(int ch) {
    for (PCharacter character : charactersInWorld) {
      if (tempCount == ch-1) {
        character.guardKilled();
      }
      tempCount++;
    }
    tempCount = 0;
  }


  ArrayList<Block> loadLevel(int levelNum) { //this generates the level
    ArrayList<Block> blocks = new ArrayList();

    //.........
    blocks.add(new ConcreteBlock(600, 600));
    blocks.add(new ConcreteBlock(720, 600));

    //........
    guard1 = new Guard(625, 500+25);
    guard2 = new Guard(675, 500+25);


    return blocks;
  }
}