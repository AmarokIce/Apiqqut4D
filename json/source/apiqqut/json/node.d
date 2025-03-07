module apiqqut.json.node;

import std.string;
import std.conv : to;

/**
* The base of node, hold the raw data.
*/
class JsonNode : JsonElement {
    private NodeType type = NodeType.UNKNOW;
    private const string raw;

    this(string raw) {
        this.raw = raw;
    }

    // TODO
    public int getAsInt() {
        import std.regex : matchAll;

        string newStr = "";
        string tempStr = replace(raw, "_", "");
        tempStr = split(tempStr, ".")[0];

        string[] zero = split(replace(tempStr, "E", "e"), "e");
        tempStr = zero[0];
        auto temp = matchAll(tempStr, "\\d+").front;
        foreach (string s; temp) {
            newStr ~= s;
        }

        if (zero.length > 1) {
            int zeroCount = to!int(zero[1]);

            for (int i = 0; i < zeroCount; i++) {
                newStr ~= "0";
            }
        }

        return to!int(tempStr);
    }

    public double getAsDouble();
    public string getAsString();
    public bool getAsBoolean();

    override void deduce();

    override NodeType getType() {
        return this.type;
    }

    override string getRawData() {
        return this.raw;
    }
}

class JsonObject : JsonElement {
    JsonNode[string] datas;

    override NodeType getType() {
        return NodeType.JSON_OBJECT;
    }

    override string getRawData() {
        string str = "{";
        foreach (string key; datas.keys) {
            str ~= ",\n    ";
            str ~= key ~ ":" ~ datas[key].getRawData;
        }

        str ~= "\n}";
        return str;
    }

    override void deduce();
}

class JsonArray : JsonElement {
    JsonNode[] nodes;

    JsonNode get(int index) {
        return nodes[index];
    }

    override NodeType getType() {
        return NodeType.JSON_ARRAY;
    }

    override string getRawData() {
        string str = "[";
        foreach (JsonNode key; nodes) {
            str ~= ",\n    ";
            str ~= key.getRawData;
        }

        str ~= "\n]";
        return str;
    }

    override void deduce();
}

abstract class JsonElement {
    abstract NodeType getType();
    abstract string getRawData();
    abstract void deduce();

    JsonObject getAsObject() {
        if (this.getType() != NodeType.JSON_OBJECT) {
            throw new Exception("This element not an object!");
        }

        return cast(JsonObject) this;
    }

    JsonArray getAsArray() {
        if (this.getType() != NodeType.JSON_ARRAY) {
            throw new Exception("This element not an array!");
        }

        return cast(JsonArray) this;
    }
}

enum NodeType {
    JSON_OBJECT,
    JSON_ARRAY,

    JSON_STRING,
    JSON_INTEGER,
    JSON_DOUBLE,
    JSON_BOOLEAN,

    // The default type.
    UNKNOW
}
