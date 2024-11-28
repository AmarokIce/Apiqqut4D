module apiqqut.event.event;

class Event {
    bool shouldCancel;

    void setCancel(bool shouldCancel = true) {
        this.shouldCancel = shouldCancel;
    }
}

enum EventPriority {
    High,
    Common,
    Low
}
