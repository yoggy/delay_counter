int count;
boolean running;
PFont pfont;

OneShotActionThread thread;
boolean auto_mode = false;
int auto_mode_count = 0;

void setup() {
  size(640, 480);
  frameRate(100);

  pfont = createFont("Impact", 200);

  clear();

  thread = new OneShotActionThread(this);
  //thread = new FireIRThread(this, "/dev/tty.usbmodem1421");  // IR remote control
  //thread = new FireNex6Thread(this); // wifi
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

  if (auto_mode) {
    if (auto_mode_count % 800 == 500) {
      clear();
    }
    if (auto_mode_count % 800 == 799) {
      fire();
      auto_mode_count = 0;
    }
    auto_mode_count ++;
  }
}

void clear() {
  count = 0;
  running = false;
}

void fire() {
  running = true;
  thread.fire();
  println("fire : " + System.currentTimeMillis());
}

void keyPressed() {
  switch(key) {
  case 0x20:
    fire();
    break;
  case 'c':
    clear();
    break;
  case 'a':
    auto_mode = !auto_mode;
    auto_mode_count = 0;
    break;
  }  
}

