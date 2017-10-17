float ground; //ground height of the world
int floor = 750;
int blockH;
int blockW;
int tempCount = 0;
int blockType;
int nearDoor;

public int floorW = 250;



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
      block.draw();
    }

    for (PCharacter character : charactersInWorld) {
      character.draw();
    }
  }

  void generateWorld() {
  }

  void killCharacter(int ch) {
    tempCount = 1;
    for (PCharacter character : charactersInWorld) {
      if (tempCount == ch) {
        character.guardKilled();
      }
      tempCount++;
    }
  }


  ArrayList<Block> loadLevel(int levelNum) { //this generates the level
    ArrayList<Block> blocks = new ArrayList();


    /*
     Block types
     blocks.add(new ConcreteBlock(360, 490));
     blocks.add(new wallBlock(200, 600));
     blocks.add(new doorWallBlock(330, 600));
     blocks.add(new doorBlock(331, 700));
     
     blocks to start each world
     blocks.add(new wallBlock(-11, 600));
     blocks.add(new wallBlock(1366, 600));
     
     Characters
     charactersInWorld.add(guard4 = new Guard(0, 0));
     
     */

    //Addblocks here  
    //.........
    blocks.add(new wallBlock(-11, 600));
    blocks.add(new wallBlock(1366, 600));
    
    blocks.add(new ConcreteBlock(400, 590));
    blocks.add(new wallBlock(410, 600));
    blocks.add(new doorWallBlock(630, 600));
    blocks.add(new doorBlock(631, 700));
    //........


    charactersInWorld.add(guard1 = new Guard(50000, 650));
    charactersInWorld.add(guard2 = new Guard(450, 750-42));
    charactersInWorld.add(guard3 = new Guard(450, 575-42));
    //charactersInWorld.add(guard4 = new Guard(0, 0));
    //charactersInWorld.add(guard5 = new Guard(0, 250-25));
    //charactersInWorld.add(guard6 = new Guard(0, 250-25));

    return blocks;
  }

  void openD() {
    nearDoor = 0;
    nearDoor = player.checkForDoor(currentWorld);

    if (nearDoor != 0) {
      tempCount = 0;
      for (Block block : currentWorld) {
        tempCount++;
        if (tempCount == nearDoor) {
          block.openDoor();
        }
      }
    } 
    return;
  }
}