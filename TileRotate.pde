class TileRotate implements Pattern {
  PVector position;
  float lifespan = 255;
  int counter = 0;
  int dir = -1;
  boolean camelPicked = false;

  TileRotate(PVector p){
    position = p.get();
  }
  
  boolean update(){    
    camelPicked = true;
    if (counter == 0 || counter == 360){
      dir = -dir;
    }
    
    if (counter >= 0 && dir == 1){
      counter++;
    }
    
    if (counter <= 360 && dir == -1){
      counter--;
    }
    
    println(counter);
    return (counter == 360);
  }
  
  boolean isDead(){
    return (lifespan <= 0);
  }
  
  void display(PShape s, color cFill){ 
    noStroke();
    s.setFill(color(cFill));
    if (camelPicked == true){
      s.rotateY(radians(360));
    } else {
      s.rotateY(radians(counter));
    }
    shape(s,position.x, position.y, 71, 63);  
  }
}