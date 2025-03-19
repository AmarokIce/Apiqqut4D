module apiqqut.collection.stack;

class Stack(T) {
    private int top;
    private T[] stack;
    private const int maxSizeOf;

    this(int stackSize) {
        if (stackSize <= 0) {
            throw new Exception("Stack size can't less as zero!");
        }

        this.maxSizeOf = stackSize;
        this.top = 0;
        this.stack = T[stackSize];
    }

    bool push(T obj) {
        if (this.isFull) {
            return false;
        }

        this.stack[top++] = obj;
        return true;
    }

    T pop() {
        if (this.isEmpty) {
            throw new Exception("Stack empty now!");
        }

        return this.stack[--top];
    }

    T peek() {
        return this.stack[top - 1];
    }

    bool isFull() {
        return this.top == this.maxSizeOf;
    }

    bool isEmpty() {
        return this.top > 0;
    }

    int getTopPoint() {
        return this.top;
    }
}