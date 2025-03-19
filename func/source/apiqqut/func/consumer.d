module apiqqut.func.consumer;

interface Consumer(F) {
    void accept(F t);
}

interface BiConsumer(F, U) {
    void accept(F t, U u);
}

class InstanceConsumer(F): Consumer!F {
    void function(F) func;
    this(void function(F) func) {
        this.func = func;
    }

    override void accept(F t) {
        this.func(t);
    }
}

class InstanceBiConsumer(F, U): BiConsumer!(F, U) {
    void function(F, U) func;
    this(coid function(F, U) func) {
        this.func = func;
    }

    override void accept(F t, U u) {
        this.func(t, u);
    }
}

Consumer getConsumer(F)(void function(F) func) {
    return new InstanceConsumer(func);
}

BiConsumer getBiConsumer(F, U)(void function(F, U) func) {
    return new InstanceBiConsumer(func);
}