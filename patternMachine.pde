//Making the pattern grid
ArrayList<Camel> camels;
PShape sCamel;
PShape sCamelFlipped;

int[] rCamel;
int[] mode = {0, 4};
//Mode 0 = get mode[1] random camels and scale fade
//Mode 1 = move lines 
//Mode 2 = 

void setup(){
  size(1280, 720, P3D);
  shapeMode(CENTER);
  sCamel = loadShape("camel.svg");
  sCamelFlipped = loadShape("camelflip.svg");
  
  camels = new ArrayList<Camel>(); 
  
  for(int row = 0; row < 6; row++){
    pushMatrix();
    translate(142,0,0);
    for(int cam = 0; cam < 15; cam++){
      PVector v = new PVector(cam*96,row*138);
      camels.add(new Camel(v));
    }
    popMatrix();
  }
  
  if (mode[0] == 0){
    rCamel = new int[mode[1]];
    for (int i = 0; i < rCamel.length; i++){
      rCamel[i] = int(random(16,camels.size()-16));
    } 
  }
}

void draw(){
  background(255,  98,  133, 255);
  
  if (mode[0] == 0){
    animationFadeScale();
  }
     
}

void animationFadeScale(){
  for(int i = camels.size()-1; i >= 0; i--){    
    Camel c = camels.get(i);
    
    for (int r = 0; r < rCamel.length; r++){
      if (i == rCamel[r]){
          boolean loop = c.update();
          if (loop == true){
              rCamel[r] = int(random(16,camels.size()-16));
          }
       }
    }
    
    if (i % 2 == 0){
      c.display(sCamel); 
    } else {
      c.display(sCamelFlipped);
    }
    
    if (c.isDead()){
      camels.remove(i);
    }  
  }
}