class Block {
  PVector pos;

  public Block(int x, int y) {
    int blockH;
    int blockW;
    pos = new PVector(x, y);
  }

  void draw() {
    rect(pos.x, pos.y, blockW, blockH);
  }

  int getBlock() {
    return 0;
  }

  boolean doorOpen() {
    return false;
  }
  
  void openDoor(){
    
  }
  
}

class ConcreteBlock extends Block {
  int blockH = 10;
  int blockW = 150;
  public ConcreteBlock( int x, int y) {
    super(x, y);
  }

  int getBlock() {
    return 0;
  }


  //super.update();
}

class wallBlock extends Block {
  int blockH = 150;
  int blockW = 10;
  public wallBlock( int x, int y) {
    super(x, y);
  }

  int getBlock() {
    return 1;
  }
}

class doorWallBlock extends Block {
  int blockH = 100;
  int blockW = 10;
  public doorWallBlock( int x, int y) {
    super(x, y);
  }

  int getBlock() {
    return 2;
  }
}

class doorBlock extends Block {
  int blockH = 50;
  int blockW = 8;
  boolean doorOpen = false;
  public doorBlock( int x, int y) {
    super(x, y);
  }

  int getBlock() {
    if (doorOpen == false) {
      return 3;
    } else {
      return 4;
    }
  }
  
  void openDoor(){
    if(doorOpen == true){
      doorOpen = false;
    } else {
      doorOpen = true;
    }
  }
}

class jumpBlock extends Block {
  int blockH = 4;
  int blockW = 40;
  public jumpBlock( int x, int y) {
    super(x, y);
  }

  int getBlock() {
    return 5;
  }
}