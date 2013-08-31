int count;
boolean running;
PFont pfont;

FireThread thread;

void setup() {
  size(640, 480);
  frameRate(100);

  pfont = createFont("Impact", 200);

  clear();

  thread = new FireThread(this);
  thread.start();
}

void draw() {
  process();
  background(0, 0, 0);
  drawCounter();
}

void drawCounter() {
  textFont(pfont);
  text(count, 30, 300);
}

void process() {
  if (running == true) {
    count ++;
  }
}

void clear() {
  count = 0;
  running = false;
}

void fire() {
  running = true;
  thread.fire();
}

void keyPressed() {
  switch(key) {
  case 0x20:
    fire();
    break;
  case 'c':
    clear();
    break;
  }
}

