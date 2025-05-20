module apiqqut.collection.list;

import apiqqut.collection.iterator;

interface List(T) {
    T add(T obj);
    T insert(T obj, int index);
    void addAll(T[] list);
    void addAll(List!T list);

    T get(int index);

    int indexOf(T object);

    bool contains(T obj);

    T removeAt(int index);
    T removeFirst(T object);

    void clear();

    int size();
    T[] asArray();

    void forEach(void function(T) func);

    Iterator!T getIterator();
}

class ListIterator(T) : Iterator!T {
    private List!T self;
    private int topPoint;

    this(List!T list) {
        this.self = list;
        this.topPoint = 0;
    }

    override T next() {
        return self.get(this.topPoint++);
    }

    override T peek() {
        return self.get(this.topPoint - 1);
    }

    override bool remove() {
        if (this.topPoint <= this.self.size) {
            this.self.removeAt(this.topPoint - 1);
            return true;
        }

        return false;
    }

    override bool hasNext() {
        return this.topPoint < this.self.size;
    }
}

unittest {
    List!string list = new ArrayList!string();
    list.add("Test0");
    list.addAll(["Test1", "Test2", "Test3", "Test3"]);

    assert(list.get(0) == "Test0");
    assert(list.get(0) == list.removeAt(0));
    assert(list.get(0) == "Test1");
    assert(list.get(2) == list.get(3));
    assert(list.contains("Test0") == false);

    list.removeFirst("Test3");
    assert(list.size() == 3);

    auto generator = list.getIterator();
    assert(generator.next() == generator.peek());
    assert(generator.next() == "Test2");
    assert(generator.next() == "Test3");
    assert(!generator.hasNext == true);
}

class ArrayList(T) : List!T {
    private T[] array;

    this() {
        this.array = new T[0];
    }

    this(T[] list) {
        this.array = list;
    }

    this(List!T list) {
        this.array = list.asArray;
    }

    override T add(T obj) {
        this.array ~= obj;
        return obj;
    }

    override T insert(T obj, int index) {
        if (index < 0 || index >= this.array.length) {
            return this.add(obj);
        }

        this.array = this.array[0 .. index] ~ obj ~ this.array[index .. $];
        return obj;
    }

    override void addAll(T[] list) {
        this.array ~= list;
    }

    override void addAll(List!T list) {
        this.array ~= list.asArray;
    }

    override T get(int index) {
        return index < 0 || index >= this.array.length ? null : this.array[index];
    }

    override int indexOf(T obj) {
        for (int i = 0; i < this.array.length; i++) {
            if (this.array[i] == obj) {
                return i;
            }
        }

        return -1;
    }

    override bool contains(T obj) {
        return this.indexOf(obj) != -1;
    }

    override T removeAt(int index) {
        if (index < 0 || index >= this.array.length) {
            return null;
        }
        T dat = this.get(index);

        T[] array1 = this.array[0 .. index];
        T[] array2 = this.array[index + 1 .. $];

        this.array = array1 ~ array2;

        return dat;
    }

    override T removeFirst(T obj) {
        int index = indexOf(obj);
        return index != -1 ? removeAt(index) : null;
    }

    override void clear() {
        this.array = new T[0];
    }

    override int size() {
        import std.conv : to;

        return to!int(this.array.length);
    }

    override T[] asArray() {
        return this.array.dup;
    }

    override void forEach(void function(T) func) {
        foreach (T obj; this.array) {
            func(obj);
        }
    }

    override Iterator!T getIterator() {
        return new ListIterator!T(this);
    }
}


unittest {
    List!string list = new LinkedList!string();
    list.add("Test0");
    list.addAll(["Test1", "Test2", "Test3", "Test3"]);

    assert(list.get(0) == "Test0");
    assert(list.get(0) == list.removeAt(0));
    assert(list.get(0) == "Test1");
    assert(list.get(2) == list.get(3));

    list.removeFirst("Test3");
    assert(list.size() == 3);

    auto generator = list.getIterator();
    assert(generator.next() == generator.peek());
    assert(generator.next() == "Test2");
    assert(generator.next() == "Test3");
    assert(!generator.hasNext == true);
}

class LinkedList(T) : List!T {
    protected class Node {
        T dat;

        Node prev;
        Node next;

        this(T dat) {
            this.dat = dat;
        }

        void setLinked(Node prev, Node next) {
            this.prev = prev;
            this.next = next;

            prev.next = this;
            next.prev = this;
        }

        void setPrev(Node prev) {
            this.prev = prev;
            prev.next = this;
        }

        void setNext(Node next) {
            this.next = next;
            next.prev = this;
        }
    }

    private Node firstNode = null;
    private Node lastNode = null;
    private int length = 0;

    this() {
    }

    this(T[] dat) {
        this.addAll(dat);
    }

    this(List!T dat) {
        this.addAll(dat);
    }

    private int setIndexInLength(int index) {
        if (index == 0) {
            return 0;
        }

        if (index >= this.length) {
            return index % this.length;
        }

        while (index < 0) {
            index = this.length - index;
        }

        return index;
    }

    private Node getNode(int index) {
        index = setIndexInLength(index);

        Node nodeNode;
        if (index > length / 2) {
            nodeNode = this.lastNode;
            for (int i = length - 1; i > index; i--) {
                nodeNode = nodeNode.prev;
            }
        } else {
            nodeNode = this.firstNode;
            for (int i = 0; i < index; i++) {
                nodeNode = nodeNode.next;
            }
        }

        return nodeNode;
    }

    override T add(T obj) {
        Node node = new Node(obj);

        if (this.length == 0) {
            this.lastNode = node;
            this.firstNode = node;
            node.prev = node;
            node.next = node;

            this.length++;
            return obj;
        }

        node.setLinked(this.lastNode, this.firstNode);
        this.lastNode = node;
        this.length++;

        return obj;
    }

    override T insert(T obj, int index) {
        Node node = new Node(obj);

        if (this.length == 0) {
            this.lastNode = node;
            this.firstNode = node;
            node.setLinked(node, node);

            this.length++;
            return obj;
        }

        Node nodeNode = this.getNode(index);
        node.setLinked(nodeNode.prev, nodeNode);
        this.length++;
        return obj;
    }

    override void addAll(T[] dats) {
        Node[] nodes = new Node[0];

        foreach (T dat; dats) {
            nodes ~= new Node(dat);
        }

        if (nodes.length == 0) {
            return;
        }

        if (this.length == 0) {
            this.lastNode = nodes[$ - 1];
            this.firstNode = nodes[0];
        }

        this.lastNode.setNext(nodes[0]);

        for (int i = 1; i < nodes.length; i++) {
            Node node = nodes[i];
            nodes[i - 1].setNext(node);
        }

        nodes[$ - 1].setNext(this.firstNode);
        this.lastNode = nodes[$ - 1];

        this.length += nodes.length;
    }

    override void addAll(List!T list) {
        this.addAll(list.asArray);
    }

    override T get(int index) {
        return this.getNode(index).dat;
    }

    override int indexOf(T obj) {
        if (this.length == 0) {
            return -1;
        }

        Node node = this.firstNode;
        int index = 0;
        do {
            if (node.dat == obj) {
                return index;
            }
            index++;
            node = node.next;
        }
        while (index != this.length);

        return -1;
    }

    override bool contains(T obj) {
        return this.indexOf(obj) != -1;
    }

    override T removeAt(int index) {
        if (this.length == 1) {
            this.length = 0;
            Node node = this.lastNode;

            this.lastNode = null;
            this.firstNode = null;

            return node.dat;
        } else if (this.length == 0) {
            return null;
        }

        Node node = this.getNode(index);

        Node prev = node.prev;
        Node next = node.next;

        prev.setNext(next);

        if (node == this.firstNode) {
            this.firstNode = next;
        }

        if (node == this.lastNode) {
            this.lastNode = prev;
        }

        this.length--;
        return node.dat;
    }

    override T removeFirst(T object) {
        if (this.length == 0) {
            return null;
        }

        int index = indexOf(object);

        return index != -1 ? removeAt(index) : null;
    }

    override void clear() {
        this.length = 0;
        this.firstNode = null;
        this.lastNode = null;
    }

    override int size() {
        return this.length;
    }

    override T[] asArray() {
        T[] arr = new T[0];
        Node node = this.firstNode;
        do {
            arr ~= node.dat;
            node = node.next;
        }
        while (node != this.firstNode);
        return arr;
    }

    override void forEach(void function(T) func) {
        Node node = this.firstNode;
        do {
            func(node.dat);
            node = node.next;
        }
        while (node != this.firstNode);
    }

    override Iterator!T getIterator() {
        return new ListIterator!T(this);
    }
}

// TODO: ImmutableList
