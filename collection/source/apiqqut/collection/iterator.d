module apiqqut.collection.iterator;

import apiqqut.collection.stack;

interface IIteratorable(T) {
    Iterator!T getIterator();
}

abstract class Iterator(T) {
    abstract T next();
    abstract T peek();
    abstract bool hasNext();
    abstract bool remove();
}

class ArrayIterator(T): Iterator!T {
    private Stack!T stack;

    this(T[] list) {
        import std.conv : to;
        const int maxSize = to!int(list.length);
        this.stack = new Stack!T(maxSize);
        for(int i = maxSize - 1; i >= 0; i--) {
            stack.push(list[i]);
        }
    }

    override T next() {
        return stack.pop();
    }

    override T peek() {
        return stack.peek();
    }

    override bool hasNext() {
        return !stack.isEmpty;
    }

    override bool remove() {
        return false;
    }
}

ArrayIterator iterator(T)(T[] arr) {
    return new ArrayIterator(arr);
}
