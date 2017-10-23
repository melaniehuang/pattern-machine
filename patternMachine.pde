/* 
ANIMATION PATTERNS 
SET MODE, BACKGROUND AND SVG FILL COLOR
*/

int selectColor;
int borderColorA;
int borderColorB;
color bg;
color f;

//int[] mode = {0, 20};
//int[] mode = {1, 6};
int[] mode = {0,20};

//Mode 0 = get mode[1] random camels and scale fade
//Mode 1 = get random line of mode[1] and remove 1st or last camel and slide
//Mode 2 = 

//PATTERN GRID
ArrayList<Pattern> tiles;
PShape sCamel;
PShape sCamelFlipped;

//FRAME
PImage photo;
PShape border;
PShape f1;
PShape ft1;
PShape f2;
PShape ft2;
PShape f3;
PShape ft3;

int[] rCamel;
int row;

//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
PImage img;
SyphonClient syphonIn;
SyphonServer syphonOut;

void setup(){
  size(1280, 720, P3D);
  background(bg);
  shapeMode(CENTER);
  sCamel = loadShape("camel.svg");
  sCamelFlipped = loadShape("camelflip.svg");
  smooth(8);  
  getColors();
  
  switch(mode[0]) {
    case 0: 
      println("Mode 0");
      makeGrid("TileFade");
      rCamel = new int[mode[1]];
      for (int i = 0; i < rCamel.length; i++){
        rCamel[i] = int(random(45,tiles.size()-45));
      } 
      break;
    case 1: 
      println("Mode 1");  // Prints "One"
      makeGrid("TileRowSlide");
      row = 1;
      break;
    case 2: 
      println("Mode 2");  // Prints "One"
      makeGrid("TileRotate");
      rCamel = new int[mode[1]];
      for (int i = 0; i < rCamel.length; i++){
        rCamel[i] = int(random(45,tiles.size()-45));
      } 
      break;
  }
  
  border = loadShape("border.svg");
  photo = loadImage("photo.png");  
  f1 = loadShape("frame1.svg");
  ft1 = loadShape("frame1-text.svg");
  f2 = loadShape("frame2.svg");
  ft2 = loadShape("frame2-text.svg");
  f3 = loadShape("frame3.svg");
  ft3 = loadShape("frame3-text.svg");
    
  canvas = createGraphics(1280, 720, P3D);
  syphonOut = new SyphonServer(this, "Simpl Syphon Send");
}

void draw(){
  
  canvas.beginDraw();
  
  bg = cPairs[selectColor][0];
  f = cPairs[selectColor][1];

  background(bg);
  if (mode[0] == 0){
    animationFadeScale();
  }

  if (mode[0] == 1){
    animationRowSlide();
  }
  
  if (mode[0] == 2){
    animationRotate();
  }
  canvas.endDraw();   
  image(canvas, 0, 0);
  syphonOut.sendImage(canvas);
}

void makeGrid(String tileType){
  //Create a list of Tiles
  tiles = new ArrayList<Pattern>(); 
  for(int row = 0; row < 15; row++){
    for(int cam = 0; cam < 40; cam++){
      PVector v;
      
      if (row % 2 == 0){
        v = new PVector(cam*46-46,row*66);
      } else {
        v = new PVector(cam*46,row*66);
      } 
      if (tileType == "TileFade") {
        tiles.add(new TileFade(v));
      }
      
      if (tileType == "TileRowSlide") {
        tiles.add(new TileRowSlide(v));
      }
      
      if (tileType == "TileRotate") {
        tiles.add(new TileRotate(v));
      }
    }    
  }
}

void animationFadeScale(){
  for(int i = tiles.size()-1; i >= 0; i--){    
    Pattern c = tiles.get(i);
    
    for (int r = 0; r < rCamel.length; r++){      
      if (i == rCamel[r]){
          boolean loop = c.update();
          if (loop == true){
              rCamel[r] = int(random(45,tiles.size()-45));
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
  
  printFrame();
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

void animationRotate(){
  for(int i = tiles.size()-1; i >= 0; i--){    
    Pattern c = tiles.get(i);
    
    for (int r = 0; r < rCamel.length; r++){       
      if (i == rCamel[r]){
          boolean loop = c.update();
          if (loop == true){
              rCamel[r] = int(random(45,tiles.size()-45));
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

void mouseClicked(){
  getColors();
}

void getColors(){
  selectColor = int(random(cPairs.length));
  borderColorA = int(random(cPairs.length));
  if (borderColorA == selectColor){
    borderColorA = int(random(cPairs.length));
  }
  borderColorB = int(random(cPairs.length));
  
  if (borderColorB == selectColor || borderColorB == borderColorA){
    borderColorB = int(random(cPairs.length));
  }
}

void printFrame(){
  shape(border, width/2+10, height/2+10);
  border.setFill(color(255));
  image(photo, 296+22, 133+14);
  shape(f1, width/2,height/2);
  f1.setFill(color(cPairs[selectColor][0]));
  shape(ft1, width/2-8,height/2-12); 
  ft1.setFill(color(cPairs[selectColor][1]));
  
  shape(f2, width/2,height/2-26);
  f2.setFill(color(cPairs[borderColorA][0]));
  shape(ft2, width/2-8, height/2-12-26); 
  ft2.setFill(color(cPairs[borderColorA][1]));
  
  shape(f3, width/2-26,height/2);
  f3.setFill(color(cPairs[borderColorB][0]));
  shape(ft3, width/2-8-42, height/2-12); 
  ft3.setFill(color(cPairs[borderColorB][1]));
}