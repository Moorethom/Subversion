float ground; //ground height of the world
int floor = 750;
int blockH;
int blockW;
int tempCount = 0;
int blockType;



class World {
  ArrayList<Block> currentWorld;
  ArrayList<PCharacter> charactersInWorld;


  public World() {
    charactersInWorld = new ArrayList();
    currentWorld = loadLevel(0);
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
      blockType = block.getBlock();
      if (blockType == 0) {
        blockH = 10;
        blockW = 150;
      } else if (blockType == 1) {
        blockH = 150;
        blockW = 10;
      } else if (blockType == 2) {
        blockH = 100;
        blockW = 10;
      } else if (blockType == 3) {
        blockH = 50;
        blockW = 8;
      }
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
    ArrayList<Block> chars = new ArrayList();

    //.........
    blocks.add(new ConcreteBlock(670, 590));
    // blocks.add(new ConcreteBlock(720, 600));
    blocks.add(new ConcreteBlock(450, 420));
    blocks.add(new ConcreteBlock(360, 490));
    blocks.add(new wallBlock(200, 600));
    blocks.add(new doorWallBlock(330, 600));
    //blocks.add(new wallBlock(720, 600));

    //........
    charactersInWorld.add(guard1 = new Guard(685, 500-25));
    charactersInWorld.add(guard2 = new Guard(375, 400-25));
    charactersInWorld.add(guard3 = new Guard(550, 100-25));
    charactersInWorld.add(guard4 = new Guard(0, 0));
    charactersInWorld.add(guard5 = new Guard(0, 250-25));
    charactersInWorld.add(guard6 = new Guard(0, 250-25));

    return blocks;
  }
}