import net.sabamiso.processing.nex6.*;

class FireThread extends Thread {
  PApplet papplet;
  Nex6 nex6;

  FireThread(PApplet papplet) {
    this.papplet = papplet;
    nex6 = new Nex6(papplet);
    boolean rv = nex6.start();
    if (rv == false) {
      println("error: nex6.start() failed...");
      exit();
      return;
    }
  }

  void run() {
    while (true) {
      try {
        synchronized(this) {
          this.wait();
        }
        doFire();
      }
      catch(Exception e) {
        e.printStackTrace();
      }
    }
  }

  synchronized void fire() {
    this.notify();
  }

  void doFire() {
    println("doFire!");
    PImage img = nex6.takePicture();
  }
}

