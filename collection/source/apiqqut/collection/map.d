module apiqqut.collection.map;

import apiqqut.collection.pair : IPair, Pair;

interface Map(K, V) {
    V put(K key, V value);
    V putIfNotExist(K key, V value);
    void putAll(V[K] map);
    void putAll(Map!(K, V) map);

    V get(K key);
    V getOrDefault(K key, V defValue);

    bool contains(K key);

    V remove(K key);
    void removeAll();

    int size();
    bool isEmpty();

    K[] keys();
    V[] values();

    IPair!(K, V)[] pairs();

    V[K] copy();

    void forEach(void function(K, V) func);
}

// The Associative Array is the Hash Map so...
class HashMap(K, V) : Map!(K, V) {
    const V[K] map;

    this() {
    }

    this(Map!(K, V) map) {
        V[K] mp = map.copy;
        foreach (K key; mp.keys) {
            this.map[key] = mp[key];
        }
    }

    this(V[K] map) {
        foreach (K key; map.keys) {
            this.map[key] = map[key];
        }
    }

    override V put(K key, V value) {
        this.map[key] = value;
        return value;
    }

    override V putIfNotExist(K key, V value) {
        V val = this.map.get(key, value);
        map[key] = val;
        return val;
    }

    override void putAll(V[K] map) {
        foreach (K key; map.keys) {
            this.map[key] = map[key];
        }
    }

    override void putAll(Map!(K, V) map) {
        this.putAll(map.copy);
    }

    override V get(K key) {
        auto dat = key in this.map;
        return dat is null ? null : *dat;
    }

    override V getOrDefault(K key, V defValue) {
        return this.map.get(key, defValue);
    }

    override bool contains(K key) {
        return !((key in this.map) is null);
    }

    override V remove(K key) {
        if (!this.contains(key)) {
            return null;
        }
        auto value = this.map[key];
        this.map.remove(key);
        return value;
    }

    override void removeAll() {
        foreach (K key; map.keys) {
            map.remove(key);
        }
    }

    override int size() {
        import std.conv : to;

        return to!int(this.map.length);
    }

    override bool isEmpty() {
        return this.size == 0;
    }

    override K[] keys() {
        return this.map.keys;
    }

    override V[] values() {
        return this.map.values;
    }

    override IPair!(K, V)[] pairs() {
        IPair!(K, V)[] pairs = new IPair!(K, V)[0];

        foreach (K key; map.keys) {
            pairs ~= new Pair!(K, V)(key, this.get(key));
        }

        return pairs;
    }

    override V[K] copy() {
        V[K] mp;
        foreach (K key; this.map.keys) {
            mp[key] = this.map[key];
        }

        return mp;
    }

    override void forEach(void function(K, V) func) {
        foreach (K key; this.keys) {
            V value = this.get(key);
            func(key, value);
        }
    }
}

class LinkedHashMap(K, V) : Map!(K, V) {
    import apiqqut.collection.list : LinkedList;

    const V[K] map;

    LinkedList!K keyList = new LinkedList!K();

    this() {
    }

    this(Map!(K, V) map) {
        V[K] mp = map.copy;
        foreach (K key; mp) {
            this.map[key] = mp[key];
            this.keyList.add(key);
        }
    }

    this(V[K] map) {
        foreach (K key; map) {
            this.map[key] = map[key];
            this.keyList.add(key);
        }
    }

    override V put(K key, V value) {
        this.map[key] = value;
        this.keyList.removeFirst(key);
        this.keyList.add(key);
        return value;
    }

    override V putIfNotExist(K key, V value) {
        map[key] = this.map.get(key, value);
        this.keyList.removeFirst(key);
        this.keyList.add(key);
        return map[key];
    }

    override void putAll(V[K] map) {
        foreach (K key; map) {
            this.map[key] = map[key];
            this.keyList.removeFirst(key);
            this.keyList.add(key);
        }
    }

    override void putAll(Map!(K, V) map) {
        this.putAll(map.copy);
    }

    override V get(K key) {
        auto dat = key in this.map;
        return dat is null ? null : *dat;
    }

    override V getOrDefault(K key, V defValue) {
        return this.map.get(key, defValue);
    }

    override bool contains(K key) {
        return !((key in this.map) is null);
    }

    override V remove(K key) {
        if (!this.contains(key)) {
            return null;
        }
        auto value = this.map[key];
        this.map.remove(key);
        this.keyList.removeFirst(key);
        return value;
    }

    override void removeAll() {
        foreach (K key; map.keys) {
            map.remove(key);
        }
    }

    override int size() {
        import std.conv : to;

        return to!int(this.map.length);
    }

    override bool isEmpty() {
        return this.size == 0;
    }

    override K[] keys() {
        return this.keyList;
    }

    override V[] values() {
        return this.map.values;
    }

    override IPair!(K, V)[] pairs() {
        IPair!(K, V)[] pairs = new IPair!(K, V)[0];

        foreach (K key; map.keys) {
            pairs ~= new Pair!(K, V)(key, this.get(key));
        }

        return pairs;
    }

    override V[K] copy() {
        V[K] mp;
        foreach (K key; this.map) {
            mp[key] = this.map[key];
        }

        return mp;
    }

    K getFirstKey() {
        return this.keyList.get(0);
    }

    K getLastKey() {
        return this.keyList.get(-1);
    }

    V putAt(K key, V value, int index) {
        this.map[key] = value;
        this.keyList.removeFirst(key);
        this.keyList.addTo(key, index);
        return value;
    }

    V removeAt(int index) {
        K key = this.keyList.removeAt(index);
        return this.remove(key);
    }

    void setKeyTo(int indexOfKey, int newIndexOf) {
        K key = this.keyList.removeAt(indexOfKey);
        this.keyList.addTo(key, newIndexOf);
    }

    void setKeyToFirst(int indexOf) {
        this.setKeyTo(indexOf, 0);
    }

    void setKeyToLast(int indexOf) {
        this.setKeyTo(indexOf, -1);
    }

    int keyAt(K key) {
        if (!this.contains(key)) {
            return -1;
        }

        for (int i = 0; i < this.keyList.size; i++) {
            if (this.keyList.get(i) == key) {
                return i;
            }
        }

        return -1;
    }

    override void forEach(void function(K, V) func) {
        foreach (K key; this.keys) {
            V value = this.get(key);
            func(key, value);
        }
    }
}

class ImmutableMap(K, V) : Map!(K, V) {
    const V[K] map;

    this() {
    }

    this(Map!(K, V) map) {
        V[K] mp = map.copy;
        foreach (K key; mp) {
            this.map[key] = mp[key];
        }
    }

    this(V[K] map) {
        foreach (K key; mp) {
            this.map[key] = mp[key];
        }
    }

    this(T = Pair!(K, V), T...)(T pairs) {
        V[K] mp;
        foreach (Pair!(K, V) pair; pairs) {
            mp[pair.key] = pair.value;
        }

        this.map = mp;
    }

    override V put(K key, V value) {
        throw new Exception("Immutable map cannot be changed!");
    }

    override V putIfNotExist(K key, V value) {
        throw new Exception("Immutable map cannot be changed!");
    }

    override void putAll(V[K] map) {
        throw new Exception("Immutable map cannot be changed!");
    }

    override void putAll(Map!(K, V) map) {
        throw new Exception("Immutable map cannot be changed!");
    }

    override V get(K key) {
        auto dat = key in this.map;
        return dat is null ? null : *dat;
    }

    override V getOrDefault(K key, V defValue) {
        return this.map.get(key, defValue);
    }

    override bool contains(K key) {
        return !((key in this.map) is null);
    }

    override V remove(K key) {
        throw new Exception("Immutable map cannot be changed!");
    }

    override void removeAll() {
        throw new Exception("Immutable map cannot be changed!");
    }

    override int size() {
        import std.conv : to;

        return to!int(this.map.length);
    }

    override bool isEmpty() {
        this.size == 0;
    }

    override K[] keys() {
        return this.map.keys;
    }

    override V[] values() {
        return this.map.values;
    }

    override IPair!(K, V)[] pairs() {
        IPair!(K, V)[] pairs = new IPair!(K, V)[0];

        foreach (K key; map.keys) {
            pairs ~= new Pair!(K, V)(key, this.get(key));
        }

        return pairs;
    }

    override V[K] copy() {
        V[K] mp;
        foreach (K key; this.map) {
            mp[key] = this.map[key];
        }

        return mp;
    }

    override void forEach(void function(K, V) func) {
        foreach (K key; this.keys) {
            V value = this.get(key);
            func(key, value);
        }
    }
}
