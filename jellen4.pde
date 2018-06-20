OPC opc;
float dx, dy;
float d, a;
PImage dot;
import processing.video.*;
Movie movie;
float xi = 250;
float x = xi;
float pX = x;
float yi = 250;
float y = yi;
float pY = y;
float movx;
float movy;
void setup()
{
  size(400, 200);
    background(0);
movie = new Movie(this, "jel1.mov");
  movie.loop();
  // Load a sample image
  dot = loadImage("color-dot.png");
  movx = 0;
  movy = 0;
  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map one 64-LED strip to the center of the window
    opc.ledStrip(0, 64, width/2, 1*height/24, width / 70.0, 0, false);
 opc.ledStrip(64, 64, width/2, 2*height/24, width / 70.0, 0, false);
  opc.ledStrip(128, 64, width/2, 3*height/24, width / 70.0, 0, false);
  opc.ledStrip(192, 64, width/2, 4*height/24, width / 70.0, 0, false);
 opc.ledStrip(256, 64, width/2, 5*height/24, width / 70.0, 0, false);
 opc.ledStrip(320, 64, width/2, 6*height/24, width / 70.0, 0, false);
opc.ledStrip(384, 64, width/2, 7*height/24, width / 70.0, 0, false);
 opc.ledStrip(448, 64, width/2, 8*height/24, width / 70.0, 0, false);
 
 //or maybe this one, 9
 
 opc.ledStrip(512, 64, width/2, 9*height/24, width / 70.0, 0, false);
 opc.ledStrip(576, 64, width/2, 10*height/24, width / 70.0, 0, false);
 opc.ledStrip(640, 64, width/2, 11*height/24, width / 70.0, 0, false);
 opc.ledStrip(704, 64, width/2, 12*height/24, width / 70.0, 0, false);
 opc.ledStrip(768, 64, width/2, 13*height/24, width / 70.0, 0, false);
 opc.ledStrip(832, 64, width/2, 14*height/24, width / 70.0, 0, false);
 opc.ledStrip(896, 64, width/2, 15*height/24, width / 70.0, 0, false);
//this one below causes the issue
opc.ledStrip(960, 64, width/2, 16*height/24, width / 70.0, 0, false);
 opc.ledStrip(1024, 64, width/2, 17*height/24, width / 70.0, 0, false);
  opc.ledStrip(1088, 64, width/2, 18*height/24, width / 70.0, 0, false);
 opc.ledStrip(1152, 64, width/2, 19*height/24, width / 70.0, 0, false);
  opc.ledStrip(1216, 64, width/2, 20*height/24, width / 70.0, 0, false);
 opc.ledStrip(1280, 64, width/2, 21*height/24, width / 70.0, 0, false);
 opc.ledStrip(1344, 64, width/2, 22*height/24, width / 70.0, 0, false);
 opc.ledStrip(1408, 64, width/2, 23*height/24, width / 70.0, 0, false);
 //opc.ledStrip(1472, 1, width/2, 24*height/24, width / 70.0, 0, false);
  colorMode(HSB, 100);
  d = 0.1;
  a = 0;
}


void movieEvent(Movie m) {
  m.read();
}

float noiseScale=0.02;

float fractalNoise(float x, float y, float z) {
  float r = 0;
  float amp = 1.0;
  for (int octave = 0; octave < 4; octave++) {
    r += noise(x, y, z) * amp;
    amp /= 2;
    x *= 2;
    y *= 2;
    z *= 2;
  }
  return r;
}
void draw()
{


if (movy-250>height){movx=random(movx-500, width); movy = 0;} 

  
  movy++;
  
long now = millis();
  float speed = 0.002;
  float angle = sin(now * 0.001);
  float z = now * 0.00008;
  float hue = now * 0.01;
  float scale = 0.005;


  dx += cos(angle) * speed;
  dy += sin(angle) * speed;

  loadPixels();
  for (int x=0; x < width; x++) {
    for (int y=0; y < height; y++) {
     
      float n = fractalNoise(dx + x*scale, dy + y*scale, z) - 0.75;
      float m = fractalNoise(dx + x*scale, dy + y*scale, z + 10.0) - 0.75;

      color c = color(
         (hue + 80.0 * m) % 100.0,
         100 - 100 * constrain(pow(3.0 * n, 3.5), 0, 0.9),
         100 * constrain(pow(3.0 * n, 1.5), 0, 0.9)
         );
      
      pixels[x + width*y] = c;
    }
  }
  if (a>100||a<-10000){d=d*-1;}
  updatePixels();
  image(movie, movx, movy-250, 500, 200);
  fill (100,100,100,a);
  rect (0,0,width,height);
  println(a);
  a = a +d;
  float dotSize = width * 0.2;
  
  
}
