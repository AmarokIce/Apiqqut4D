module apiqqut.json.codec;

import std.conv : to;
import std.string;
import std.regex;

import apiqqut.json.node;

class Codec(T) {
    abstract public string encode(T data);
    abstract public T decode(string data);
}

final class StringCodec : Codec!string {
    static StringCodec INSTANCE;
    shared static this() {
        INSTANCE = new StringCodec();
    }

    override public string encode(string data) {
        return data;
    }

    override public string decode(string data) {
        return data;
    }
}

final class IntegerCodec : Codec!int {
    static IntegerCodec INSTANCE;
    shared static this() {
        INSTANCE = new IntegerCodec();
    }

    override public string encode(int data) {
        return to!string(data);
    }

    override public int decode(const string data) {
        replace(data, "_", "");
        const string dat = split(data, ".")[0];
        if (!matchFirst(dat, regex("\\D")).empty) {
            throw new Exception("Type not integer!");
        }

        return to!int(dat);
    }
}

final class DoubleCodec : Codec!double {
    static DoubleCodec INSTANCE;
    shared static this() {
        INSTANCE = new DoubleCodec();
    }

    override public string encode(double data) {
        return to!string(data);
    }

    override public double decode(string data) {
        replace(data, "_", "");
        if (count(data, ".") > 1) {
            throw new Exception("Type not double!");
        }

        if (endsWith(toLower(data), "d")) {
            data = data[0 .. to!int(data.length) - 1];
        }

        auto dats = split(data, ".");
        foreach (string str; dats) {
            if (!matchFirst(str, regex("\\D")).empty) {
                throw new Exception("Type not integer!");
            }
        }

        return to!double(data);
    }
}

final class BooleanCodec : Codec!bool {
    static BooleanCodec INSTANCE;
    shared static this() {
        INSTANCE = new BooleanCodec();
    }

    override public string encode(bool data) {
        return to!string(data);
    }

    override public bool decode(string data) {
        return toLower(data) == "true";
    }
}

final class ArrayCodec : Codec!(JsonNode[]) {
    static ArrayCodec INSTANCE;
    shared static this() {
        INSTANCE = new ArrayCodec();
    }

    override public string encode(JsonNode[] data) {
        // TODO
        return "[]";
    }

    override public JsonNode[] decode(string data) {
        // TODO
        return [];
    }
}

final class MapCodec : Codec!(JsonNode[string]) {
    static MapCodec INSTANCE;
    shared static this() {
        INSTANCE = new MapCodec();
    }
    override public string encode(JsonNode[string] data) {
        // TODO
        return "{}";
    }

    override public JsonNode[string] decode(string data) {
        // TODO
        return new JsonNode[string];
    }
}
