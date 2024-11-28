module apiqqut.collection.iterator;

import apiqqut.collection.list : ArrayList;

// TODO

interface IIterator(T) {
    Iterator!T getIterator();
}

class Iterator(T) {
    List!T list;

    this(List!T list) {
        this.list = new ArrayList(list);
    }

    this(T[] list) {
        this.list = new ArrayList(list);
    }


    T next() {
        return list.removeAt(0);
    }

    bool hasNext() {
        return list.size > 0;
    }
}
