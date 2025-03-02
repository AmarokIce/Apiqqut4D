module apiqqut.json.node;

import apiqqut.json.codec;

class JsonNode {
    const string baseData;

    this(const string base) {
        this.baseData = base;
    }

    public T get(T)(Codec!T codec) {
        return codec.encode(baseData);
    }

    public string getString() {
        return StringCodec.INSTANCE.decode(baseData);
    }

    public int getInteger() {
        return IntegerCodec.INSTANCE.decode(baseData);
    }

    public double getDouble() {
        return DoubleCodec.INSTANCE.decode(baseData);
    }

    public JsonNode[] getArray() {
        return ArrayCodec.INSTANCE.decode(baseData);
    }

    public JsonNode[string] getMap() {
        return MapCodec.INSTANCE.decode(baseData);
    }
}
