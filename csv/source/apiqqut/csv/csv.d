module apiqqut.csv.csv;

import std.file;
import std.string;
import std.conv : to;

alias TargetType = string[][string];

void encodec(TargetType data, string filePath, bool lineModeCodec = false) {
    string csvString(string str) => "\"" ~ str ~ "\"";
    string[][] dataList = new string[][0];
    string[] keys = data.keys;
    foreach (string key; keys) {
        string[] value = data[key];
        dataList ~= (new string[0]) ~ key ~ value;
    }

    string[] lines = new string[0];
    int max;
    foreach (string[] list; dataList) {
        if (list.length > max) {
            max = to!int(list.length);
        }
    }

    if (lineModeCodec) {
        foreach (string[] list; dataList) {
            string line;
            for (int i = 0; i < max; i++) {
                if (list.length < i) {
                    string val = list[i];
                    line ~= indexOf(val, ",") > 0 ? val : csvString(val);
                }

                line ~= ",";
            }
            lines ~= line[0 .. $ - 1];
        }
    } else {
        for (int i = 0; i < max; i++) {
            string line;
            foreach (string[] list; dataList) {
                if (list.length < i) {
                    string val = list[i];
                    line ~= indexOf(val, ",") > 0 ? val : csvString(val);
                }
                line ~= ",";
            }
            lines ~= line[0 .. $ - 1];
        }
    }

    write(filePath, "");
    foreach(string line; lines) {
        append(filePath, line ~"\n");
    }
}

TargetType decodec(string filePath, bool lineModeCodec = false) {
    string[] texts = splitLines(readText(filePath));

    string[][] csvDatas = new string[][0];

    foreach (string line; texts) {
        string[] splits = splitCsv(line);
        csvDatas ~= splits;
    }

    string[][string] map;

    for (int i = 0; i < csvDatas.length; i++) {
        string[] dat = csvDatas[i];
        if (lineModeCodec) {
            map[dat[0]] = dat[1 .. $];
            continue;
        }

        if (i == 0) {
            foreach (string key; dat) {
                map[key] = new string[0];
            }
            continue;
        }

        for (int o = 0; o < dat.length; o++) {
            map[csvDatas[0][o]] ~= dat[o];
        }
    }

    return map;
}

private string[] splitCsv(string line) {
    string[] words = new string[0];
    bool start;
    while (line.length > 0) {
        if (line.startsWith("\"")) {
            int index = to!int(indexOf(line[1 .. $], '\"'));
            if (index == -1) {
                throw new Error("The string has start but no end!");
            }

            words ~= line[1 .. index];
            if (index + 1 == line.length) {
                return words;
            }

            line = line[index + 2 .. $];
            continue;
        }

        int index = to!int(indexOf(line, ','));
        if (index == -1) {
            words ~= line;
            return words;
        }

        words ~= line[0 .. index];
        line = line[index + 1 .. $];
    }

    return words;
}
