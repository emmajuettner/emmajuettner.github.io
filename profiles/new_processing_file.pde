/* @pjs preload="http://emmajuettner.github.io/profiles/1.jpg, http://emmajuettner.github.io/profiles/2.jpg, http://emmajuettner.github.io/profiles/3.jpg, http://emmajuettner.github.io/profiles/4.jpg, http://emmajuettner.github.io/profiles/5.jpg, http://emmajuettner.github.io/profiles/6.jpg, http://emmajuettner.github.io/profiles/7.jpg, http://emmajuettner.github.io/profiles/8.jpg, http://emmajuettner.github.io/profiles/9.jpg, http://emmajuettner.github.io/profiles/10.jpg, http://emmajuettner.github.io/profiles/11.jpg, http://emmajuettner.github.io/profiles/12.jpg, http://emmajuettner.github.io/profiles/13.jpg, http://emmajuettner.github.io/profiles/14.jpg, http://emmajuettner.github.io/profiles/15.jpg, http://emmajuettner.github.io/profiles/16.jpg, http://emmajuettner.github.io/profiles/17.jpg, http://emmajuettner.github.io/profiles/18.jpg, http://emmajuettner.github.io/profiles/19.jpg, http://emmajuettner.github.io/profiles/20.jpg, http://emmajuettner.github.io/profiles/output_list_copy.txt"; font="http://emmajuettner.github.io/profiles/BookmanOldStyle-48.vlw";*/

PFont font;
String[] lines;
String[] line_values = {};
int[] line_counts = {};
int x;
int y;
String value;
int count;
String[] split_arr;
String item;
PImage face_shape;
float rand;
boolean silhouette_found;
int[] silhouette_positions;
int offset;
float theta;
int timecount;
int fadecount;

float xdist;
float ydist;
float len;

PImage photo, maskImage;
PGraphics pg;

void setup() {
  
  //basic setup
  frameRate(2);
  size(1000,1000);
  background(255);
  lines = loadStrings("output_list_copy.txt");
  font = loadFont("BookmanOldStyle-48.vlw");
  
  photo = loadImage("1.jpg");
  photo.resize(int(photo.width/3.5),int(photo.height/3.5));
  pg = createGraphics(photo.width,photo.height);
  println(photo.width, photo.height);
  pg.beginDraw();
  pg.background(0);
  pg.fill(255);
  pg.ellipse(500-260,500-300,380,380);
  pg.endDraw();
  maskImage = pg;
  photo.mask(maskImage);
  tint(255,20);
  image(photo,260,300);
  noTint();
  
  fadecount = 0;
  //get values and counts to print
  //textFont(font);
  
  for (int i = 0; i < lines.length; i++){
    //println(lines[i]);
    split_arr = split(lines[i], '"');
    item = split_arr[1];
    //println(item);
    line_values = append(line_values, item);
    item = split_arr[2];
    item = item.substring(1,item.length());
    //println(item);
    line_counts = append(line_counts, Integer.parseInt(item));
  }
  
  line_values = reverse(line_values);
  line_counts = reverse(line_counts);
  
  
  theta = 0;//radians(360.0/line_values.length);
  offset = 1;
  /*for (int i = 0; i < line_values.length; i++){
    value = line_values[i];
    count = line_counts[i];
    
    rand = 0;//1500-int(log(random(0,(2000-count))));
    textFont(font,(log(count)+1)*30);
    println(log(count));
    fill(29,161,242);
    translate(2500,2500);
    rotate(theta+rand);
    //textAlign(CENTER);
    text(line_values[i],0,0);
    translate(-2500,-2500-rand);
    
  }*/
  timecount = 0;
  len = 200;
  
  
}

void draw() {
  value = line_values[timecount];
  count = line_counts[timecount];
  
  if(timecount>(line_values.length-1)){
    timecount=0;
  }
  
  //update profile pic
  if(timecount%6==0 && timecount!=0 && timecount<6*20){
    photo = loadImage(""+(timecount/6+1)+".jpg");
    photo.resize(int(photo.width/3.5),int(photo.height/3.5));
    photo.mask(maskImage);
    tint(255,50);
    image(photo,260,300);
    noTint();
  }
  else{
    tint(255,50);
    image(photo,260,300);
    noTint();
  }
  if(timecount>6*20){
    fill(255, 255, 255, fadecount);
    rect(0,0,1000,1000);
    fadecount++;
  }
  
  rand = radians(timecount*10);//1500-int(log(random(0,(2000-count))));
  theta = theta+rand;
  
  //calculate offset to make blank circle in center
  xdist = len*cos(rand);
  ydist = len*sin(rand);
  println(xdist,ydist);
  
  //overlay a rectangle to dim opacity of older text
  //tint(255, 255, 255, 1);
  fill(255, 255, 255, 20);
  rect(0,0,1000,1000);
  //noTint();
  
  textFont(font,38);//(log(count)+1)*10);
  println("printing "+line_values[timecount]);
  fill(29,161,242);
  translate(500+xdist,500+ydist);
  rotate(rand);
  //textAlign(CENTER);
  text(line_values[timecount],0,0);
  translate(-500-xdist,-500-ydist);
  //save("circle_output/visual_output"+str(timecount)+".png");
  timecount++;
}