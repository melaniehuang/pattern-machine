class Camel {
  PVector position;
  float lifespan = 255;
  int a = 254;
  int neg = 2;
  float angle = 0;

  Camel(PVector p){
    position = p.get();
  }
  
  boolean update(){    
    if (a == 0 || a == 254) { 
      neg = -neg; 
    }
    
    a += neg;

    if (a == 254){
      return true;
    } else {
      angle += 0.04;
      return false;
    }
  }
  
  boolean isDead(){
    return (lifespan <= 0);
  }
  
  void display(PShape p){ 
    noStroke();
    //tint(255, a);
    p.setFill(color(255,204,204,a));
    int imageWidth = 142;
    int imageHeight = 125;
    float w = imageWidth-10 + (sin(angle) * 8);
    float h = imageHeight-10 + (sin(angle) * 8);
    shape(p,position.x, position.y, w, h);  
  }
}