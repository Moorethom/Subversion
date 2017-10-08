class World {
  ArrayList<Block> currentWorld;
  ArrayList<PCharacter> charactersInWorld;

  //Temp
  int blockH = 30;
  int blockW = 30;



  public World() {
    currentWorld = loadLevel(0);
    charactersInWorld = new ArrayList();
  }

  void update() {

    for (PCharacter character : charactersInWorld) {
      character.update();
      character.collideWithObjects(currentWorld);
    }
    line(0, ground, 1000, ground);
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
    blocks.add(new ConcreteBlock(420, 300));
    blocks.add(new ConcreteBlock(500, 500));
    blocks.add(new ConcreteBlock(420, 300));
    blocks.add(new ConcreteBlock(420, 300));
    blocks.add(new ConcreteBlock(420, 300));
    blocks.add(new ConcreteBlock(420, 300));


    return blocks;
  }
}