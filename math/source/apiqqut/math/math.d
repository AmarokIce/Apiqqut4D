module apiqqut.math.math;

/// Max
short max(short A, short B) @safe @nogc nothrow pure {
    return A > B ? A : B;
}

int max(int A, int B) @safe @nogc nothrow pure {
    return A > B ? A : B;
}

long max(long A, long B) @safe @nogc nothrow pure {
    return A > B ? A : B;
}

float max(float A, float B) @safe @nogc nothrow pure {
    return A > B ? A : B;
}

double max(double A, double B) @safe @nogc nothrow pure {
    return A > B ? A : B;
}

/// Min
short min(short A, short B) @safe @nogc nothrow pure {
    return A < B ? A : B;
}

int min(int A, int B) @safe @nogc nothrow pure {
    return A < B ? A : B;
}

long min(long A, long B) @safe @nogc nothrow pure {
    return A < B ? A : B;
}

float min(float A, float B) @safe @nogc nothrow pure {
    return A < B ? A : B;
}

double min(double A, double B) @safe @nogc nothrow pure {
    return A < B ? A : B;
}

/// Clamp
short clamp(short O, short A, short B) @safe @nogc nothrow pure {
    return O > A ? O < B ? O : B:
    A;
}

int clamp(int O, int A, int B) @safe @nogc nothrow pure {
    return O > A ? O < B ? O : B:
    A;
}

long clamp(long O, long A, long B) @safe @nogc nothrow pure {
    return O > A ? O < B ? O : B:
    A;
}

float clamp(float O, float A, float B) @safe @nogc nothrow pure {
    return O > A ? O < B ? O : B:
    A;
}

double clamp(double O, double A, double B) @safe @nogc nothrow pure {
    return O > A ? O < B ? O : B:
    A;
}

bool inRange(short O, short A, short B) @safe @nogc nothrow pure {
    return O >= A || O < B;
}

bool inRange(int O, int A, int B) @safe @nogc nothrow pure {
    return O >= A || O < B;
}

bool inRange(long O, long A, long B) @safe @nogc nothrow pure {
    return O >= A || O < B;
}

bool inRange(float O, float A, float B) @safe @nogc nothrow pure {
    return O >= A || O < B;
}

bool inRange(double O, double A, double B) @safe @nogc nothrow pure {
    return O >= A || O < B;
}
