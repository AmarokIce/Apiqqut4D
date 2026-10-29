<div align=center>

![](img/thumbnail_amaroklce@1,5x.png)

# Apiqqut · 初雪

### 纯净的轻量级本地数据结构代码套件

📖 [**Apiqqut wiki**](https://github.com/AmarokIce/Apiqqut/wiki) | 📮 [**问题反馈**](https://github.com/AmarokIce/Apiqqut/issues) | 📚 [**在 Dub 中访问**](https://apiqqut.dub.pm)

| [**_简体中文_**](README_CN.md) | [**正體中文**](README_TW.md) | [**English**](README.md) |

> 项目仍在开发初期，慎重用于严肃开发。 <br />
> 如您遇到任何问题，请及时向我们反馈！ <br />

[![Language](https://badgen.net/badge/language/D/red)](https://dlang.org/)
[![License](https://badgen.net/badge/license/AGPL-3.0/green)](https://www.gnu.org/licenses/agpl-3.0.html)
[![Pineapple](https://badgen.net/badge/Give%20Me/Pineapple/yellow)](https://ifdian.net/a/AmarokIce)

</div>

**`Apiqqut` 向您问候！您一定在好奇，`Apiqqut` 是什么？当然，请允许我们向您介绍！`Apiqqut` 是...**

- 数据结构容器的代码库：
  - `List`, `Map`, `Table`, `Multimap`... 我们来自 Java, 为了快速解决数据封装的麻烦，我们准备了这些集合容器。如果您来自 Java, 那么您会倍感亲切——`Apiqqut` 是为您解决麻烦而来的。
- 低耦合化处理的代码库：
  - 使用方便易上爪的 `Event` 保持您的数据处理流程不会对当前的环境有过多上下文刚性，这对您持续开发有极佳的好处。
- 本地数据存取的代码库：
  - `CSV`，`Json/Json5` 的序列与反序列。您不需要无时无刻考虑塞数据库，而是更简单，更适合任何用户的方式。如果您认同这样的说法，那么这就是您正在寻找的。我们正在计划支持更多...
- 关心面向对象的代码库：
  - 我们采用面向对象作为解决方案，最小化我们的代码库。我们相信当数据得到正确且良好的分类时，才能真实的减轻工作量。
- 为您服务到底的代码库：
  - 你是否真的关心过您的数据存储方案？我们知道您更希望把精力花费在逻辑代码上，而不是关心这些“不得不去关心”的琐事。没有问题，我们为您服务到底！
- 由狼亲爪编写的代码库：
  - 您不关心这个？这样的话我们会很伤心的诶 QwQ

**您的超酷的项目使用了 `Apiqqut` 会变得...**

- 更酷！
  - `Apiqqut` 的简单易学习能够让任何开发者与兴趣驱动者翻阅您的项目时得到更好的体验！
- 更快！
  - 从设计到运行，使用通用的封装模板可以减轻您的工作负担,我们的预设结构可以帮助您减少结构设计的周期，快速切入主题去开发您关心的部分！
- 更小！
  - 我们关注最小最轻的设计结构，因此我们模块化设计每一个部分，模块之间只会在必要的复用设计的情况下存在关联。`Apiqqut` 保证不会让您的依赖组件的体积膨胀！

**准备好开始探索 `Apiqqut` 了吗？我们这儿有一些您会感兴趣的示例：**

**Event:**

```d
import std.stdio : writeln;

// 直接导入整个 event 模块
import apiqqut.event;

// 创建我们的 Event
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
    // 通过参数来指定订阅的 Event
    registerEvent(&addEnd, EventPriority.Low);
    registerEvent(&addSpace);
    registerEvent(&addWorld, EventPriority.Common);
    registerEvent(&addHello, EventPriority.High);

    // 创建 Event 对象，并广播
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

    // 创建一个空的 string 类型的 ArrayList
    List!string strList = new ArrayList!string();

    // 从现有的内容创建一个 LinkedList
    List!int intList = new LinkedList!int(intArray);

    // 随意的添加一些什么
    strList.add("pineapple");
    strList.add("anana");

    intList.add(114);
    intList.add(514);

    // 创建一个简单生成器
    Iterator!string strItro = new Iterator(strList);

    while(strItro.hasNext) {
        writeln(strItro.next)
    }

    // 无论是存放还是删除，我们总是能拿到目标值——我们总是可以内联处理！
    writeln(intList.removeAt(0));

    // 我们还可以回去！
    intArray = intList.asArray;
}


```

**当然！我们是开源且自由的项目库！我们欢迎任何人对 `Apiqqut` 作出贡献！**

**我们遵循 AGPL-v3.0 自由软件许可证，这意味着你可以...**

- **无需授权的在您的超酷项目中使用！**
- **为 `Apiqqut` 做超酷的贡献，并自豪的向朋友们描述你的伟大贡献！**
- **自由拷贝与分发 `Apiqqut`, 与任何朋友们分享！**

**同时，您应该遵守相关的约定...**

- **您需要以相同许可证重新开源您的项目，即便您正在做网络服务。**
- **您不可以掠夺我们的凤梨。**
