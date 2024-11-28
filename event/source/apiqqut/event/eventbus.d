module apiqqut.event.eventbus;

import apiqqut.event.event;

//* Event List
private void function(Event)[][EventPriority][ClassInfo] eventMap;

void registerEvent(T : Event)(void function(T) event, EventPriority priority = EventPriority.Common) {
    void function(Event)[][EventPriority] data;
    if (T.classinfo in eventMap) {
        data = eventMap[T.classinfo];
    }

    void function(Event)[] events = priority in data ? data[priority] : new void function(Event)[0];

    events ~= cast(void function(Event)) event;
    data[priority] = events;

    eventMap[T.classinfo] = data;
}

T postEvent(T : Event)(T event) {
    ClassInfo eventClass = event.classinfo;

    void function(Event)[][EventPriority] eventDatas;
    if (auto val = eventClass in eventMap) {
        eventDatas = *val;
    } else
        return event;

    foreach(EventPriority priority; [EventPriority.High, EventPriority.Common, EventPriority.Low]) {
        if (!(priority in eventDatas)) {
            continue;
        }

        foreach (void function(Event) eventFunc; eventDatas[priority]) {
            eventFunc(event);

            if (event.shouldCancel) {
                return;
            }
        }
    }

    return event;
}
