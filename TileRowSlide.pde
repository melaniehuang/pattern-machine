class TileRowSlide implements Pattern {
  PVector position;
  float lifespan = 255;
  int a = 254;
  int neg = 2;
  float angle = 0;

  TileRowSlide(PVector p){
    position = p.get();
  }
  
  boolean update(){    
    if (a == 0 || a == 254) { 
      neg = -neg; 
    }
    
    a += neg;
    
    if (a != 254){
      angle += 0.02;
    }
    return (a == 254);
  }
  
  boolean isDead(){
    return (lifespan <= 0);
  }
  
  void display(PShape p, color cFill){ 
    noStroke();
    p.setFill(color(cFill,a));
    float w = p.width-10 + (sin(angle) * 8);
    float h = p.height-10 + (sin(angle) * 8);
    shape(p,position.x, position.y, w, h);  
  }
}