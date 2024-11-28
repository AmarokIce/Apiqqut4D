module apiqqut.json.jsonnode;

enum NodeType {
    String,
    Integer,
    Long,
    Float,
    Double,
    Boolean,
    Array,
    Map,
    Null
}

abstract class JsonNode(T) {
    protected T obj;

    this(T obj) {
        this.obj = obj;
    }

    NodeType getType() {
        return NodeType.Null;
    }

    T getObj() {
        return this.obj;
    }
}

class AnyNode : JsonNode!string {
    this(string str) {
        super(str);

    }


}
