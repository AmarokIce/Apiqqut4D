module apiqqut.math.vector;

import apiqqut.math.direction;
import std.conv : to;

public class Vec2 {
    public double x;
    public double y;

    public static Vec2 ZERO;

    static this() {
        ZERO = new Vec2(0, 0);
    }

    this(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public void add(Vec2 vec) {
        this.x += vec.x;
        this.y += vec.y;
    }

    public void subtract(Vec2 vec) {
        this.x -= vec.x;
        this.y -= vec.y;
    }

    public void multiply(Vec2 vec) {
        this.x *= vec.x;
        this.y *= vec.y;
    }

    public void except(Vec2 vec) {
        this.x /= vec.x;
        this.y /= vec.y;
    }

    public double distanceManhattan(Vec2 vec) {
        import std.math : abs;

        return abs(this.x - vec.x) + abs(this.y - vec.y);
    }

    public int distanceChebyshev(Vec2 vec) {
        import std.math : abs, floor;
        import std.conv : to;
        import apiqqut.math.math : max;

        auto ot = floor(max(abs(vec.x - this.x), abs(vec.y - this.y)));
        return to!int(ot);
    }

    public void move(Vec3 dir) {
        this.add(dir.toVec2);
    }

    public Vec2i toVec2i() {
        return new Vec2i(to!int(this.x), to!int(this.y));
    }
}

class Vec2i {
    public int x;
    public int y;

    public static Vec2i ZERO;

    static this() {
        ZERO = new Vec2i(0, 0);
    }

    this(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public void add(Vec2i vec) {
        this.x += vec.x;
        this.y += vec.y;
    }

    public void subtract(Vec2i vec) {
        this.x -= vec.x;
        this.y -= vec.y;
    }

    public void multiply(Vec2i vec) {
        this.x *= vec.x;
        this.y *= vec.y;
    }

    public void except(Vec2i vec) {
        this.x /= vec.x;
        this.y /= vec.y;
    }

    public int distanceManhattan(Vec2i vec) {
        import std.math : abs;

        return abs(this.x - vec.x) + abs(this.y - vec.y);
    }

    public int distanceChebyshev(Vec2i vec) {
        import std.math : abs, floor;
        import apiqqut.math.math : max;

        auto ot = max(abs(vec.x - this.x), abs(vec.y - this.y));
        return to!int(ot);
    }

    public void move(Vec3 dir) {
        this.add(dir.toVec2.toVec2i);
    }

    public Vec2 toVec2() {
        return new Vec2(this.x, this.y);
    }
}

class Vec3 {
    public double x;
    public double y;
    public double z;

    public static Vec3 ZERO;

    static this() {
        ZERO = new Vec3(0, 0, 0);
    }

    this(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public void add(Vec3 vec) {
        this.x += vec.x;
        this.y += vec.y;
        this.z += vec.z;
    }

    public void subtract(Vec3 vec) {
        this.x -= vec.x;
        this.y -= vec.y;
        this.z -= vec.z;
    }

    public void multiply(Vec3 vec) {
        this.x *= vec.x;
        this.y *= vec.y;
        this.z *= vec.z;
    }

    public void except(Vec3 vec) {
        this.x /= vec.x;
        this.y /= vec.y;
        this.z /= vec.z;
    }

    public double distanceManhattan(Vec3 vec) {
        import std.math : abs;

        return abs(this.x - vec.x) + abs(this.y - vec.y) + abs(this.z - vec.z);
    }

    public int distanceChebyshev(Vec3 vec) {
        import std.math : abs, floor;
        import std.conv : to;
        import apiqqut.math.math : max;

        auto ot = floor(max(abs(vec.x - this.x), abs(vec.y - this.y)));
        return to!int(ot);
    }

    public void move(Vec3 dir) {
        this.add(dir);
    }

    public Vec3i toVec3i() {
        return new Vec3i(to!int(this.x), to!int(this.y), to!int(this.z));
    }

    public Vec2 toVec2() {
        return new Vec2(this.x, this.z);
    }
}

class Vec3i {
    public int x;
    public int y;
    public int z;

    public static Vec3i ZERO;

    static this() {
        ZERO = new Vec3i(0, 0, 0);
    }

    this(int x, int y, int z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public void add(Vec3i vec) {
        this.x += vec.x;
        this.y += vec.y;
        this.z += vec.z;
    }

    public void subtract(Vec3i vec) {
        this.x -= vec.x;
        this.y -= vec.y;
        this.z -= vec.z;
    }

    public void multiply(Vec3i vec) {
        this.x *= vec.x;
        this.y *= vec.y;
        this.z *= vec.z;
    }

    public void except(Vec3i vec) {
        this.x /= vec.x;
        this.y /= vec.y;
        this.z /= vec.z;
    }

    public int distanceManhattan(Vec3i vec) {
        import std.math : abs;

        return abs(this.x - vec.x) + abs(this.y - vec.y) + abs(this.z - vec.z);
    }

    public int distanceChebyshev(Vec3i vec) {
        import std.math : abs, floor;
        import std.conv : to;
        import apiqqut.math.math : max;

        auto ot = max(abs(vec.x - this.x), abs(vec.y - this.y));
        return to!int(ot);
    }

    public void move(Vec3 dir) {
        this.add(dir.toVec3i);
    }

    public Vec3 toVec3() {
        return new Vec3(this.x, this.y, this.z);
    }

    public Vec2i toVec2i() {
        return new Vec2i(this.x, this.z);
    }
}
