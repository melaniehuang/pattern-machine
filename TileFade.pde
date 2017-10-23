class TileFade implements Pattern {
  PVector position;
  float lifespan = 255;
  int a = 254;
  int neg = 2;
  float angle = 0;

  TileFade(PVector p){
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
  
  void display(PShape s, color cFill){ 
    noStroke();
    s.setFill(color(cFill,a));
    float w = s.width-11 + (cos(angle) * 6);
    float h = s.height-11 + (cos(angle) * 6);
    shape(s,position.x, position.y, w, h);  
  }
}

//10 + (sin(angle + PI) * diameter/2) + diameter/2;
//p.height-10 + (sin(angle) * 8);