module apiqqut.cache.cache;

import apiqqut.collection.map;

// TODO
//! @Beta

abstract class Cache(T) {
    protected int size;
    this(int size) {
        this.size = size;
    }

    T put(string key, T value);
    T get(string key);
    bool contains(string key);
}

class LinkedCache(T) : Cache!T {
    LinkedHashMap!(string, T) map = new LinkedHashMap!(string, T)();

    this(int size = 50) {
        super(size);
    }

    override T put(string key, T value) {
        if (this.map.size == this.size) {
            this.map.removeAt(0);
        }

        return this.map.put(key, value);
    }

    override T get(string key) {
        if (!this.contains(key)) {
            return null;
        }

        int indexOf = this.map.keyAt(key);
        if (indexOf == -1) {
            return null;
        }

        this.map.setKeyToLast(indexOf);
        return map.get(key);
    }

    override bool contains(string key) {
        return this.map.contains(key);
    }
}
