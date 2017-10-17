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
  public doorBlock( int x, int y) {
    super(x, y);
  }

  int getBlock() {
    return 3;
  }
}