module apiqqut.func.functional;

interface Function(F, O) {
    O compose(F f);
}

interface BiFunction(F, U, O) {
    O compose(F f, U u);
}


class InstanceFunction(F): Function!F {
    O function(F) func;
    this(O function(F) func) {
        this.func = func;
    }

    override O accept(F t) {
        this.func(t);
    }
}

class InstanceBiFunction(F, U): BiFunction!(F, U) {
    O function(F, U) func;
    this(O function(F, U) func) {
        this.func = func;
    }

    override O accept(F t, U u) {
        this.func(t, u);
    }
}

Function getFunction(F)(O function(F) func) {
    return new InstanceFunction(func);
}

BiFunction getBiFunction(F, U)(O function(F, U) func) {
    return new InstanceBiFunction(func);
}