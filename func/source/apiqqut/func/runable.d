module apiqqut.func.runable;

interface Runable {
    void run();
}

class InstanceRunable : Runable {
    void function() func;
    this(void function() func) {
        this.func = func;
    }

    override void run() {
        this.func();
    }
}

Runable getRunable(void function() func) = new InstanceRunable(func);