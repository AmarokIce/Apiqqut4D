module apiqqut.collection.table;

import apiqqut.collection.map;

// Row, Col, Value
interface Table(R, C, V) {
    V add(R row, C col, V value);
    void add(R row, V[C] value);
    void add(R row, Map!(C, V) value);

    V remove(R row, C col);
    Map!(C, V) remove(R row);

    V get(R row, C col);
    Map!(C, V) get(R row);

    bool contains(R row, C col);
    bool contains(R row);

    int size();
    bool isEmpty();
}

class HashTable(R, C, V) : Table!(R, C, V) {
    const HashMap!(R, HashMap!(C, V)) table;

    this() {
        this.table = new HashMap!(R, HashMap!(C, V))();
    }

    this(C[V][R] map) {
        this.table = new HashMap(map);
    }

    this(Map!(R, Map!(C, V)) map) {
        this.table = new HashMap(map);
    }

    override V add(R row, C col, V value) {
        auto dat = this.get(row);
        dat = dat is null ? new HashMap!(C, V) : dat;

        dat.put(col, value);
        this.table.put(row, dat);
        return value;
    }

    override void add(R row, V[C] value) {
        auto dat = this.get(row);
        if (dat is null) {
            this.table.put(new HashMap(dat));
        } else {
            dat.putAll(value);
        }
    }

    override V add(R row, Map!(C, V) value) {
        return this.add(row, value.copy);
    }

    override V remove(R row, C col) {
        auto dat = this.get(row);
        if (this.dat is null) {
            return null;
        }

        return dat.remove(col);
    }

    override Map!(C, V) remove(R row) {
        return this.table.remove(row);
    }

    override V get(R row, C col) {
        auto value = this.table.get(row);
        if (value is null) {
            return null;
        }

        return value.get(col);
    }

    override Map!(C, V) get(R row) {
        return this.table.get(row);
    }

    override bool contains(R row, C col) {
        auto dat = this.get(row);
        return dat is null ? false : dat.contains(col);
    }

    override bool contains(R row) {
        return this.table.contains(row);
    }

    override bool isEmpty() {
        return this.table.isEmpty();
    }

    override int size() {
        return this.table.size();
    }
}
