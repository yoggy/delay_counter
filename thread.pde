import net.sabamiso.processing.nex6.*;

class FireNex6Thread extends OneShotActionThread {
  Nex6 nex6;

  FireNex6Thread(PApplet papplet) {
    super(papplet);
    
    nex6 = new Nex6(papplet);

    boolean rv = nex6.start();
    if (rv == false) {
      println("error: nex6.start() failed...");
      exit();
      return;
    }
  }

  void doFire() {
    println("FireNex6Thread::doFire()");
    PImage img = nex6.takePicture();
  }
}

class OneShotActionThread extends Thread {
  PApplet papplet;

  OneShotActionThread(PApplet papplet) {
    this.papplet = papplet;
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
    println("OneShotActionThread::doFire()");
  }
}

