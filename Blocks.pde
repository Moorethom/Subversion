class Block {
  PVector pos;
  
  
  public Block(int x, int y) {
    pos = new PVector(x, y);
  }
  
  void draw() {
    rect(pos.x, pos.y, 30, 30); 
  }
}

class ConcreteBlock extends Block {
  public ConcreteBlock( int x, int y) {
    super(x, y);
    
    
  }
  
}