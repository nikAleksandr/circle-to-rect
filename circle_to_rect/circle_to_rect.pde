PImage img;
PVector center,loc;

void setup(){
  img = loadImage("tree.jpg");
  
  //width shoudl be equal to the circumference of the circle
  //and height equal to the radius.  Will use half the image height as proxy for radius
  int r = 200;
  float c = 2*PI*r;
  println(c);
  size(1256,200);
}

void draw(){
  image(img,0,0);
  int iw = img.width;
  int ih = img.height;
  center = new PVector(iw/2, ih/2);
  loadPixels();
  //loop through the pixels, first by column, then by row
  for(int x = 0; x<iw; x++){
     for(int y = 0; y<ih; y++){
       int pLoc = x * y * iw;
       //grab pixel value
       float grey = red(img.pixels[pLoc]);
       //create cartesian vector for current pixel location
       loc = new PVector(x,y);
       //convert to polar coordinates oriented to center
       loc = cartesianToPolar(loc);
       //convert polar to new cartesian coords
         //new x = angle * imagewidth/360;
         //new y = magnitude *imageheight;
       float newX = loc.x * iw/360;
       float newY = loc.y * ih;
       int newPLoc = round(newX) * round(newY) * iw;
       pixels[newPLoc] = color(grey); 
     }
  }
  
}

// Converts 2D cartesian coordinates to polar coordinates
// 
// theVector : vector to convert
// returns   : vector containing 'length' and 'angle' from the center 
//            

PVector cartesianToPolar(PVector theVector) {
  PVector res = new PVector();
  res.x = theVector.mag();
  if (res.x > 0) {
    res.y = atan2(theVector.y - center.y, theVector.x - center.x);
  } 
  else {
    res.y = 0;
  }
  return res;
}