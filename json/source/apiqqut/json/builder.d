module apiqqut.json.builder;


//! @BETA
//! TODO - Overwrite all.

interface ITask {
    ITask addTask(ITask task);
    string toJson();
    string toJson5();
}

class MapBuilder : ITask {
    ITask[] taskList = new ITask[0];

    override ITask addTask(ITask task) {
        taskList ~= task;
        return this;
    }

    override string toJson() {
        string str;
        return str;
    }

    override string toJson5() {
        string str;
        return str;
    }

    ITask add(string key, string value) {
        return this.addTask(new PairTask(key, value));
    }

    private class PairTask : ITask {
        private string key, value;
        this(string key, string value) {
            this.key = key;
            this.value = value;
        }

        override ITask addTask(ITask task) {
            return this;
        }

        override string toJson() {
            return key ~ ": " ~ "value";
        }

        override string toJson5() {
            return this.toJson;
        }
    }
}

class ArrayBuilder : ITask {
    ITask[] taskList = new ITask[0];

    override ITask addTask(ITask task) {
        taskList ~= task;
        return this;
    }

    override string toJson() {
        string str;
        return str;
    }

    override string toJson5() {
        string str;
        return str;
    }
}
