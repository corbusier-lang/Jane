# Jane

**Jane** is a Swift DSL for **Corbusier** language. It's main usage is to prototype and explore **Corbusier** with Swift type-safety. It supports every feature of **CoreCorbusier**.

## Usage

**Corbusier** code:

```
place area.left.top < 20 > rect.right.top
let bottom = area.bottom
let guide = area2.top < 50 > bottom
place guide
```

**Jane** code:

```swift
try jane(in: context) { j in
    j.place(o("area").at("left").at("top").distance(10).from(i("rect").at("right").at("top")))
    j.jlet("bottom").equals(i("area").at("bottom"))
    j.jlet("guide").equals(o("area2").at("top").distance(50).from(i("bottom")))
    j.place(i("guide"))
}
```