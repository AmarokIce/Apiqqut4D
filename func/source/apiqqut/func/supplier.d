module apiqqut.func.supplier;

interface Supplier(T) {
    T get();
}

class InstanceSupplier(T) : Supplier!T {
    private const T data;

    this(T data) {
        this.data = data;
    }

    override T get() {
        return this.data;
    }
}

class FunctionSupplier(T) : Supplier!T {
    private const T function() data;

    this(T function() data) {
        this.data = data;
    }

    override T get() {
        return this.data();
    }
}

Supplier!T getSupplier(T)(T obj) {
    return new InstanceSupplier(obj);
}

Supplier!T getSupplier(T)(T function() func) {
    return new FunctionSupplier(func);
}
