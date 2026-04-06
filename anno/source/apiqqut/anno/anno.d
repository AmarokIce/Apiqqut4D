module apiqqut.anno.anno;

enum When {
  Never,
  Maybe,
  Sometime,
  Offen,
  Always
}

struct Nullable {
  When when = When.Always;
}

struct Nonnull {
  When when = When.Always;
}

struct CheckForNull {
  When when = When.Maybe;
}

struct Nonnegative {
  When when = When.Always;
}

struct Beta {
  string reson = "";
  string startVersion = "";
}

struct Deprecated {
  string reson = "";
  string stratVersion = "";
  string endVersion = "";
  string using = "";
  string also = "";
}
