float ground = 550; //ground height of the world
int floor = 550;
int blockH = 15;
int blockW = 120;

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

 
  ArrayList<Block> loadLevel(int levelNum) { //this generates the level
    ArrayList<Block> blocks = new ArrayList();

    //.........
    blocks.add(new ConcreteBlock(300, 460));
    blocks.add(new ConcreteBlock(440, 330));
    blocks.add(new ConcreteBlock(580, 400));
    blocks.add(new ConcreteBlock(300, 220));
    blocks.add(new ConcreteBlock(180, 305));
    //blocks.add(new ConcreteBlock(420, 340));
    //........

    return blocks;
  }
}