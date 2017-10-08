class Block {
  PVector pos;
  int blockH = 30;
  int blockW = 30;
  
  
  public Block(int x, int y) {
    pos = new PVector(x, y);
  }
  
  void draw() {
    rect(pos.x, pos.y, blockH, blockW); 
  }
}

class ConcreteBlock extends Block {
  public ConcreteBlock( int x, int y) {
    super(x, y);
    
    
  }
  
}