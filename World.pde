float ground = 550; //ground height of the world
int floor = 550;
int blockH = 30;
int blockW = 80;

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
      character.collideWithObjects(currentWorld);
    }
    line(0, floor, 1000, floor);
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

  ArrayList<Block> loadLevel(int levelNum) {
    ArrayList<Block> blocks = new ArrayList();

    // .....

    blocks.add(new ConcreteBlock(400, 460));
    blocks.add(new ConcreteBlock(420, 300));
    blocks.add(new ConcreteBlock(420, 300));
    blocks.add(new ConcreteBlock(420, 300));


    return blocks;
  }
}