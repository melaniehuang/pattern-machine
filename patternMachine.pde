/* 
ANIMATION PATTERNS 
SET MODE, BACKGROUND AND SVG FILL COLOR
*/

int[] mode = {0, 5};
color bg = color(255,  98,  133);
color f = color(255,204,204);
//Mode 0 = get mode[1] random camels and scale fade
//Mode 1 = move lines 
//Mode 2 = 

//PATTERN GRID
ArrayList<Tile> tiles;
PShape sCamel;
PShape sCamelFlipped;

int[] rCamel;

void setup(){
  size(1280, 720, P3D);
  background(bg);
  shapeMode(CENTER);
  sCamel = loadShape("camel.svg");
  sCamelFlipped = loadShape("camelflip.svg");
  
  //Create a list of Tiles
  tiles = new ArrayList<Tile>(); 
  for(int row = 0; row < 6; row++){
    pushMatrix();
    translate(142,0,0);
    for(int cam = 0; cam < 15; cam++){
      PVector v = new PVector(cam*96,row*138);
      tiles.add(new Tile(v));
    }
    popMatrix();
  }
 
  switch(mode[0]) {
    case 0: 
      rCamel = new int[mode[1]];
      for (int i = 0; i < rCamel.length; i++){
        rCamel[i] = int(random(16,tiles.size()-16));
      } 
      break;
    case 1: 
      println("New Mode");  // Prints "One"
      break;
  }

}

void draw(){
  background(bg);
  
  if (mode[0] == 0){
    animationFadeScale();
  }
     
}

void animationFadeScale(){
  for(int i = tiles.size()-1; i >= 0; i--){    
    Tile c = tiles.get(i);
    
    for (int r = 0; r < rCamel.length; r++){
      if (i == rCamel[r]){
          boolean loop = c.update();
          if (loop == true){
              rCamel[r] = int(random(16,tiles.size()-16));
          }
       }
    }
    
    if (i % 2 == 0){
      c.display(sCamel, f); 
    } else {
      c.display(sCamelFlipped, f);
    }
    
    if (c.isDead()){
      tiles.remove(i);
    }  
  }
}