module apiqqut.json.types;

class Any(T = void) {
    protected void* object;

    this() {
    }

    this(T object) {
        this.object = &object;
    }

    void set(T object) {
        this.object = &object;
    }
}

class String : Any!string {
}

class Integer : Any!int {
}

class Long : Any!long {
}

class Float : Any!float {
}

class Double : Any!double {
}

class Boolean : Any!bool {
}
