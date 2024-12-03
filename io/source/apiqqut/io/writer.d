module apiqqut.io.writer;

interface IWriter {
    void wrtie(ubyte[] bytes);
    void overwrite(ubyte[] bytes);

    bool canWrite();
    bool lock();
    bool unlock();
}
