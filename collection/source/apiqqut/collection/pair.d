module apiqqut.collection.pair;

interface IPair(A, B) {
    void set(A key, B value);
    A setKey(A key);
    B setValue(B value);

    A getKey();
    B getValue();
}

class Pair(A, B) : IPair!(A, B) {
    A key;
    B value;

    this(A key, B value) {
        this.key = key;
        this.value = value;
    }

    override void set(A key, B value) {
        this.key = key;
        this.value = value;
    }

    override A setKey(A key) {
        this.key = key;
        return key;
    }

    override B setValue(B value) {
        this.value = value;
        return value;
    }

    override A getKey() {
        return this.key;
    }

    override B getValue() {
        return this.value;
    }
}

final class ImmutablePair(A, B) : IPair!(A, B) {
    const A key;
    const B value;

    this(A key, B value) {
        this.key = key;
        this.value = value;
    }

    override void set(A key, B value) {
        throw new Exception("Immutable Pair cannot be set!");
    }

    override A setKey(A key) {
        throw new Exception("Immutable Pair cannot be set!");
    }

    override B setValue(B value) {
        throw new Exception("Immutable Pair cannot be set!");
    }

    override A getKey() {
        return this.key;
    }

    override B getValue() {
        return this.value;
    }
}
