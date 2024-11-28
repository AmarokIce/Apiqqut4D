module apiqqut.collection.conv;

import std.conv : to;

//! @Beta

V[K] mapTo(K, V, C, T)(C[T] dat) {
    V[K] map;
    foreach(T key; dat) {
        map[to!K(key)] = to!V(dat[key]);
    }
    return map;
}

// TODO - for what?
