module apiqqut.io.file;

import std.file;
import core.sys.linux.sys.inotify;
import core.sys.windows.winbase;

//! @Beta
//! The class `File` still in beta!

class File {
    const string path;

    this(string path) {
        this.path = path;
    }

    ubyte[] readBytes() {
        return cast(ubyte[]) read(path);
    }

    string readString() {
        return readText(path);
    }

    bool del() {
        try {
            remove(path);
        } catch (FileException e) {
            return false;
        }

        return true;
    }

    bool move(string newPath) {
        return this.dir ? this.moveDir(newPath) : this.moveFile(newPath);
    }

    private bool moveDir(string newPath) {
        File file = new File(newPath);

        foreach (File f; file.allFileList) {
            if (f.dir) {
                f.del;
            } else if (!moveFile(f.getPath)) {
                return false;
            }
        }

        return true;
    }

    private bool moveFile(string newPath) {
        try {
            auto bytes = this.readBytes;
            File file = new File(newPath);
            file.mkdirs;
            file.overwrite(bytes);
            this.del;
        } catch (FileException e) {
            return false;
        }

        return true;
    }

    void mkdirs() {
        mkdir(this.getParent);
    }

    void overwrite(void[] data) {
        write(this.path, data);
    }

    void appendwrite(void[] data) {
        append(this.path, data);
    }

    File[] fileList() {
        File[] arr = new File[0];

        if (!this.dir) {
            return arr;
        }

        foreach (string path; dirEntries(this.path, SpanMode.shallow)) {
            arr ~= new File(path);
        }

        return arr;
    }

    File[] allFileList() {
        File[] arr = new File[0];

        if (!this.dir) {
            return arr;
        }

        foreach (string path; dirEntries(this.path, SpanMode.depth)) {
            arr ~= new File(path);
        }

        return arr;
    }

    bool file() {
        return isFile(this.path);
    }

    bool dir() {
        return isDir(this.path);
    }

    string getParent() {
        import std.string;

        return replace(this.path, split(this.path, "/")[$ - 1], "");
    }

    string getFileName() {
        import std.string;

        return split(this.path, "/")[$ - 1];
    }

    string getPath() {
        return this.path;
    }

    string getFileTime() {
        // TODO

        return "";
    }
}
