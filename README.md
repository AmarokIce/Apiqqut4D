<div align=center>

![](img/thumbnail_amaroklce@1,5x.png)

# Apiqqut · 初雪
### Lightweight library for data storage

📖 [**Apiqqut wiki**](https://github.com/AmarokIce/Apiqqut/wiki) | 📮 [**Send Issues**](https://github.com/AmarokIce/Apiqqut/issues) | 📚 [**Ask in Dub**](https://apiqqut.dub.pm)

| [**简体中文**](README_CN.md) | [**正體中文**](README_TW.md) | [***English***](README.md) |

> The project still in BETA, never make it used for serious development. <br />
> If you find out any issue, Please keep report it to us with send issues. <br />

[![Language](https://badgen.net/badge/language/D/red)](https://dlang.org/)
[![License](https://badgen.net/badge/license/AGPL-3.0/green)](https://www.gnu.org/licenses/agpl-3.0.html)
[![Pineapple](https://badgen.net/badge/Give%20Me/Pineapple/yellow)](https://ifdian.net/a/AmarokIce)

</div>

**`Apiqqut` greetings to you!You must be curious what is`Apiqqut`?Sure!Let as show you what `Apiqqut` is...**
- Library for for data structure collection:
  - `List`, `Map`, `Table`, `Multimap`... we come from Java, and we in order to solve the hassle of encapsulation, we have prepared these collection. If you come from Java too, that will make you feel more at home —— `Apiqqut` is here to solve your problems.
- Library for low-coupling:
  - `Event` is convenient to use, keep your code still low-coupling is excellent benefits for continuous development. Yes, KISS.
- Library for local data access:
  - `CSV`,`Json/Json5` codec here. You don't need to think about using a database all the time. A simpler and more user-friendly approach that what you need. If you agree with such a statement, then this is what you are looking for. We plan to support more...
- Library for care about object-oriented:
  - We adopted object-orientation as a solution to minimize our codebase. We believe that when the data is properly and well classified, the workload can be truly reduced.
- Library for serve to you:
  - Do you really care about your data storage solution? We know you'd rather spend your energy on logical code than on the "have to care" stuff. No problem, we're here for you to the end!
- Library create by real wolf:
  - You didn't care this? We're going to be very sad about that QwQ

**Your cool project used `Apiqqut` will...**
- More cool!
  - `Apiqqut` is very simple, both everyone devers and hobbyists will get a better experience when flipping through your projects!
- More fast!
  - From design to running, using a common template can ease your workload, and our preset structures can help you reduce the cycle time of structural design and quickly cut into the topic to develop the parts you care about!
- More light!
  - We focus on the smallest and lightest design structures, so we modularize each part and only relate to each other where it is necessary to reuse the design. 'Apiqqut' is guaranteed not to bloat the volume of your dependencies!


**Ready to start exploring `Apiqqut`? We have some examples here that you may be interested in:**

**Event:**
```d
import std.stdio : writeln;

// Import the package `event`
import apiqqut.event;

// Create our Event
class DataEvent : Event {
    string text;
    this(string text) {
        this.text = text;
    }
}

void addHello(DataEvent event) {
    event.text ~= "Hello";
}

void addSpace(DataEvent event) {
    event.text ~= " ";
}

void addWorld(DataEvent event) {
    event.text ~= "world";
}

void addEnd(DataEvent event) {
    event.text ~= "!";
}

void main() {
    // Subscription event by parameters
    registerEvent(&addEnd, EventPriority.Low);
    registerEvent(&addSpace);
    registerEvent(&addWorld, EventPriority.Common);
    registerEvent(&addHello, EventPriority.High);

    // Create object Event and posting it.
    auto event = new DataEvent("");
    postEvent(event);

    // "Hello world!"
    writeln(event.text);
}
```


**Collection:**
```d
import std.stdio : writeln;
import apiqqut.collection.list;
import apiqqut.collection.iterator : Iterator;

void main() {
    int[] intArray = new int[0];

    // A empty ArrayList with string type
    List!string strList = new ArrayList!string();

    // A LinkedList with out intArray
    List!int intList = new LinkedList!int(intArray);

    // Add something
    strList.add("pineapple");
    strList.add("anana");

    intList.add(114);
    intList.add(514);

    // A simple Iterator
    Iterator!string strItro = new Iterator(strList);

    while(strItro.hasNext) {
        writeln(strItro.next)
    }

    // Add or remove, we always get the target value
    writeln(intList.removeAt(0));

    // We can back to array too!
    intArray = intList.asArray;
}


```

**Of course we are an open source and free project library! Welcome anyone to contribute to 'Apiqqut'!**

**We follow the AGPL-v3.0, which means you can:...**
- **Use it in your cool projects without authorization!**
- **Make cool contributions to 'Apiqqut' and proudly describe your great contributions to your friends!**
- **Copy and distribute 'Apiqqut' freely and share it with any of your friends!**

**At the same time, you should abide by the relevant agreements...**
- **You'll need to re-open source your project under the same license, even if you're doing web services.**
- **You can't plunder our pineapples.**
