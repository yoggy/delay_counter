import processing.serial.*;
import net.sabamiso.processing.nex6.*;

class FireIRThread extends OneShotActionThread {
  Serial serial;

  FireIRThread(PApplet papplet, String port) {
    super(papplet);
    
    serial = new Serial(papplet, port, 115200);

    if (serial == null) {
      println("error: open serial port failed...port=" + port);
      exit();
      return;
    }
  }

  void doFire() {
    println("FireIRThread::doFire() : " + System.currentTimeMillis());
    serial.write('s');
  }
}

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
    println("FireNex6Thread::doFire() : " + System.currentTimeMillis());
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
    println("OneShotActionThread::doFire() : " + System.currentTimeMillis());
  }
}

