module apiqqut.math.direction;

import apiqqut.math.vector;

class Dicrection {
    static Vec3 EAST;
    static Vec3 SOUTH;
    static Vec3 WEST;
    static Vec3 NORTH;
    static Vec3 UP;
    static Vec3 DOWN;

    static this() {
        EAST = new Vec3(1, 0, 0);
        SOUTH = new Vec3(0, 0, -1);
        WEST = new Vec3(-1, 0, 0);
        NORTH = new Vec3(0, 0, 1);
        UP = new Vec3(0, 1, 0);
        DOWN = new Vec3(0, -1, 0);
    }
}
