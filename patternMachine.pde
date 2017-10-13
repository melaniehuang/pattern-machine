/* 
ANIMATION PATTERNS 
SET MODE, BACKGROUND AND SVG FILL COLOR
*/

//int[] mode = {0, 5};
int[] mode = {1, 6};
color bg = color(255,  98,  133);
color f = color(255,204,204);
//Mode 0 = get mode[1] random camels and scale fade
//Mode 1 = get random line of mode[1] and remove 1st or last camel and slide
//Mode 2 = 

//PATTERN GRID
ArrayList<Pattern> tiles;
PShape sCamel;
PShape sCamelFlipped;

int[] rCamel;
int row;

void setup(){
  size(1280, 720, P3D);
  background(bg);
  shapeMode(CENTER);
  sCamel = loadShape("camel.svg");
  sCamelFlipped = loadShape("camelflip.svg");
  
  switch(mode[0]) {
    case 0: 
      println("Mode 0");
      makeGrid("TileFade");
      rCamel = new int[mode[1]];
      for (int i = 0; i < rCamel.length; i++){
        rCamel[i] = int(random(16,tiles.size()-16));
      } 
      break;
    case 1: 
      println("Mode 1");  // Prints "One"
      makeGrid("TileRowSlide");
      //row = int(random(mode[1]));
      row = 1;
      break;
  }

}

void draw(){
  background(bg);
  
  if (mode[0] == 0){
    animationFadeScale();
  }

  if (mode[0] == 1){
    animationRowSlide();
  }
     
}

void makeGrid(String tileType){
  //Create a list of Tiles
  tiles = new ArrayList<Pattern>(); 
  for(int row = 0; row < 6; row++){
    pushMatrix();
    translate(142,0,0);
    for(int cam = 0; cam < 15; cam++){
      PVector v = new PVector(cam*96,row*138);
      
      if (tileType == "TileFade") {
        tiles.add(new TileFade(v));
      }
      
      if (tileType == "TileRowSlide") {
        tiles.add(new TileRowSlide(v));
      }
    }
    popMatrix();
  }
}

void animationFadeScale(){
  for(int i = tiles.size()-1; i >= 0; i--){    
    Pattern c = tiles.get(i);
    
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

void animationRowSlide(){
  //print grid
  //get row
  //fade first or last camel out
  //translate row sideways in prev direction
  //print new camel at opposite end
  
  for(int i = tiles.size()-1; i >= 0; i--){    
    Pattern c = tiles.get(i);
    // if row = 1, all camels between 15 and 29
    if (i >= 15 && i <= 29){
      for (int r = row*15+14; r >= row*14+row; r--){ 
        boolean loop = c.update();
        if (loop == true){
          row = int(random(mode[1]));
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