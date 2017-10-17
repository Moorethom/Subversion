float ground; //ground height of the world
int floor = 750;
int blockH;
int blockW;
int tempCount = 0;
int blockType;
int nearDoor;

int tempBC = 0;

int x;
int y;

Block tempBlock;
String tempStr;

public int floorW = 250;



class World {
  ArrayList<Block> currentWorld;
  ArrayList<PCharacter> charactersInWorld;


  public World() {
    charactersInWorld = new ArrayList();
    currentWorld = loadLevel(currentLevel);
    for(PCharacter character : charactersInWorld) {  
      playersInWorld++;
    }
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
      } else if (blockType == 5) {
        blockH = 4;
        blockW = 40;
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
    tempCount = 0;
    for (PCharacter character : charactersInWorld) {
      tempCount++;
      if (tempCount == ch) {
        character.guardKilled();
        playersInWorld--;
      }
    }
  }


  ArrayList<Block> loadLevel(int levelNum) { //this generates the level
    ArrayList<Block> blocks = new ArrayList();
    
    String level = String.valueOf(levelNum);

    /*
     Block types
     blocks.add(new ConcreteBlock(360, 490));
     blocks.add(new wallBlock(200, 600));
     blocks.add(new doorWallBlock(330, 600));
     blocks.add(new doorBlock(331, 700));
     blocks.add(new jumpBlock(700, 592));
     
     Characters
     charactersInWorld.add(guard = new Guard(0, 0));
     */
    
    String[] lines = loadStrings(level+".txt"); //loads file
    
    for (int i = 0; i<lines.length; i++) { 
      if (lines[i].contains("ConcreteBlock")) { //looks for select block
        lines[i] = lines[i].replaceAll("[^-?0-9]+", ""); //turns block into numbers
        x = Integer.parseInt(lines[i]); //makes str into int
        y = Integer.parseInt(lines[i+1]); //makes str into int
        blocks.add(new ConcreteBlock(x, y)); //adds new block
      }
      if (lines[i].contains("wallBlock")) { //looks for select block
        lines[i] = lines[i].replaceAll("[^-?0-9]+", ""); //turns block into numbers
        x = Integer.parseInt(lines[i]); //makes str into int
        y = Integer.parseInt(lines[i+1]); //makes str into int
        blocks.add(new wallBlock(x, y)); //adds new block
      }
      if (lines[i].contains("jumpBlock")) { //looks for select block
        lines[i] = lines[i].replaceAll("[^-?0-9]+", ""); //turns block into numbers
        x = Integer.parseInt(lines[i]); //makes str into int
        y = Integer.parseInt(lines[i+1]); //makes str into int
        blocks.add(new jumpBlock(x, y)); //adds new block
      }
      if (lines[i].contains("doorWallBlock")) { //looks for select block
        lines[i] = lines[i].replaceAll("[^-?0-9]+", ""); //turns block into numbers
        x = Integer.parseInt(lines[i]); //makes str into int
        y = Integer.parseInt(lines[i+1]); //makes str into int
        blocks.add(new doorWallBlock(x, y)); //adds new block
      }
      if (lines[i].contains("doorBlock")) { //looks for select block
        lines[i] = lines[i].replaceAll("[^-?0-9]+", ""); //turns block into numbers
        x = Integer.parseInt(lines[i]); //makes str into int
        y = Integer.parseInt(lines[i+1]); //makes str into int
        blocks.add(new doorBlock(x, y)); //adds new block
      }
      if (lines[i].contains("Guard")) { //looks for select block
        lines[i] = lines[i].replaceAll("[^-?0-9]+", "");
        x = Integer.parseInt(lines[i]); //makes str into int
        y = Integer.parseInt(lines[i+1]); //makes str into int
        charactersInWorld.add(guard = new Guard(x, y)); //adds new guard
      }
    }
    
    return blocks;
  }


  void openD() { //This checks for player trying to open a door
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