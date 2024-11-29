module apiqqut.json.json;

import std.string;
import std.conv : to;
import std.file;

V[string] parseMap(V)(string inp) {
    return parseMap(readText(path));
}

V[string] parseMap(V)(string inp) {
    string[string] dat = parseMapBase(inp);
    return to!(V[string])(dat);
}

T[] parseListByFile(T)(string path) {
    return parseList(readText(path));
}

T[] parseList(T)(string inp) {
    string[] dat = parseListBase(inp);
    return to!T(dat);
}

/*************************/
/* Private Function Area */
/*************************/

/**
* Scan a list or map in range. Index the tail of list or map;
*/
private int rangeAll(string inp, bool rangeList = true, int startAt = 0) {
    const char endingDat = rangeList ? ']' : '}';
    for (int i = startAt + 1; i < inp.length; i++) {
        char c = inp[i];

        switch (c) {
        case '[':
            i = rangeAll(inp, true, i);
            break;
        case '{':
            i = rangeAll(inp, false, i);
            break;
        case endingDat:
            return i;
        default:
            break;
        }
    }

    throw new Exception("The data range start but no end!");
}

private string[] parseListBase(string inp) {
    string[] data = new string[0];

    if (inp[0] != '[' || inp[$ - 1] != ']') {
        throw new Exception("Cannot parse to list by json string: not a list!");
    }

    string[] lines = splitLines(inp);

    foreach (string line; lines) {
        line = line.split("//")[0];
        string dat = "";
        for (int i = 0; i < line.length; i++) {
            char c = line[i];
            switch (c) {
            case '\"':
                break;
            case '\\':
                dat ~= c;
                dat ~= line[++i];
                break;
            case ',':
                data ~= dat;
                dat = "";
                break;
            case '{', '[':
                int index = rangeAll(line, c == '[', i);
                dat ~= line[i .. index + 1];
                i = index;
                break;
            default:
                dat ~= c;
                break;
            }
        }
        data ~= dat;
    }

    return data;
}

private string[string] parseMapBase(string inp) {
    string[string] data;

    if (inp[0] != '{' || inp[$ - 1] != '}') {
        throw new Exception("Cannot parse to list by json string: not a list!");
    }

    string[] lines = splitLines(inp);

    foreach (string line; lines) {
        line = line.split("//")[0];

        bool keyReady;
        string key = "";
        string value = "";

        void putc(char pDat) {
            if (!keyReady) {
                key ~= pDat;
            } else {
                value ~= pDat;
            }
        }

        void puts(string pDat) {
            if (!keyReady) {
                key ~= pDat;
            } else {
                value ~= pDat;
            }
        }

        for (int i = 0; i < line.length; i++) {
            char c = line[i];
            switch (c) {
            case '\"':
                break;
            case '\\':
                putc(c);
                putc(line[++i]);
                break;
            case ',':
                if (!keyReady) {
                    throw new Exception("The map's pair ending to early!");
                }
                data[key] = value;
                key = value = "";
                break;
            case ':':
                if (keyReady) {
                    throw new Exception("The map's pair ending to late!");
                }
                keyReady = true;
                break;
            case '{', '[':
                int index = rangeAll(line, c == '[', i);
                puts(line[i .. index + 1]);
                i = index;
                break;
            default:
                putc(c);
                break;
            }
        }
        data[key] = value;
    }

    return data;
}
