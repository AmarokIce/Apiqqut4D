module apiqqut.collection.multimap;

import apiqqut.collection.list;
import apiqqut.collection.map;


interface Multimap(K, V) {
    V put(K key, V value);
    void putAll(K key, V[] value);
    void putAll(K key, List!V value);

    List!V get(K key);
    V get(K key, int index);

    bool contains(K key);

    List!V remove(K key);
    V remove(K key, V value);
    V removeAt(K key, int index);

    void removeAll();

    K[] keys();
    List!(V)[] values();
}

class HashMultimap(K, V) : Multimap!(K, V) {
    Map!(K, ArrayList!V) map = new HashMap!(K, ArrayList!V)();

    this() {
    }

    this(V[][K] aList) {
        foreach(K key; aList.keys) {
            this.map.put(key, new ArrayList(aList[key]));
        }
    }

    this(Map!(K, ArrayList!V) map) {
        this.map.putAll(map);
    }

    override V put(K key, V value) {
        this.map.putIfNotExist(cast(K)key, new ArrayList!V()).add(cast(V)value);
        return value;
    }

    override void putAll(K key, V[] list) {
        this.map.putIfNotExist(key, new ArrayList!V()).addAll(list);
    }

    override void putAll(K key, List!V list) {
        this.putAll(key, list.asArray);
    }

    override ArrayList!V get(K key) {
        return this.map.get(key);
    }

    override V get(K key, int index) {
        return this.contains(key) ? this.get(key).get(index) : null;
    }

    override bool contains(K key) {
        return this.map.contains(key);
    }

    override ArrayList!V remove(K key) {
        return this.map.remove(key);
    }

    override V removeAt(K key, int index) {
        if (!this.contains(key)) {
            return null;
        }

        import apiqqut.math.math : inRange;

        auto list = this.get(key);
        if (inRange(index, 0, list.size)) {
            return null;
        }

        return list.removeAt(index);
    }

    override V remove(K key, V value) {
        return this.contains(key) ? this.get(key).removeFirst(value) : null;
    }

    override void removeAll() {
        this.map.removeAll();
    }

    override K[] keys() {
        return this.map.keys();
    }

    override List!(V)[] values() {
        return cast(List!(V)[])this.map.values();
    }
}
