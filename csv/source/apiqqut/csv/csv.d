module apiqqut.csv.csv;

import std.string;
import std.conv : to;

string encodec(string[][] data, string filePath = "") {
    string datas = "";

    foreach (string[] line; data) {
        foreach (string str; line) {
            datas ~= "\"" ~ str ~ "\"" ~ ",";
        }
        datas = datas[0 .. -1] ~ "\n";
    }

    if (filePath != "") {
        import std.file : mkdir, write;

        mkdir(replace(filePath, split(filePath, "/")[$ - 1], ""));
        write(filePath, datas);
    }

    return datas;
}

string encodecFromRow(string[][string] data, string filePath = "") {
    string[][] datas = new string[][data.length];
    string[] keys = data.keys;
    for (int i = 0; i < keys.length; i++) {
        string key = keys[i];
        datas[i] = key ~ data[key];
    }

    return encodec(datas, filePath);
}

string encodecFromCol(string[][string] data, string filePath = "") {
    string[][] datas = new string[][1];
    string[] keys = data.keys;
    datas[0] = keys;
    for (int i = 0; i < keys.length; i++) {
        string key = keys[i];
        string[] dat = data[key];
        for (int o = 1; o <= dat.length; o++) {
            if (o >= datas.length) {
                datas ~= new string[0];
            }
            string[] val = datas[o];

            while (val.length < i) {
                val ~= "";
            }

            val[i] = dat[o];
        }
    }

    return encodec(datas, filePath);
}

string[][] decodec(string datas) {
    string[] lines = splitLines(datas);

    string[][] data = new string[][lines.length];

    for (int i = 0; i < lines.length; i++) {
        data[i] = new string[0];

        string line = lines[i];
        string str = "";
        for (int o = 0; o < line.length; o++) {
            char c = line[o];

            switch (c) {
            case '\"':
                break;
            case '\\':
                str ~= c;
                str ~= line[++o];
                break;
            case ',':
                data[i] ~= str;
                str = "";
                break;
            default:
                str ~= c;
                break;
            }
        }
        data[i] ~= str;
    }

    return data;
}

string[][string] decodecToRow(string datas) {
    string[][] csvlist = decodec(datas);
    string[][string] dataRow;
    foreach (string[] str; csvlist) {
        dataRow[str[0]] = str[1 .. $];
    }

    return dataRow;
}

string[][string] decodecToCol(string datas) {
    string[][] csvlist = decodec(datas);
    string[][string] dataCol;

    string[] keyLine = csvlist[0];

    foreach (string key; keyLine) {
        dataCol[key] = new string[0];
    }

    for (int i = 1; i < csvlist.length; i++) {
        string[] lineOf = csvlist[i];
        for (int o = 0; o < keyLine.length; o++) {
            if (o >= lineOf.length) {
                break;
            }
            dataCol[keyLine[o]] ~= lineOf[o];
        }
    }

    return dataCol;
}
