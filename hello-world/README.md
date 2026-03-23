# hello-world


## hello.zig

```zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World"});
}
```

## Run immediately

```
zig run hello.zig
```


## Create executable

```
zig build-exe hello.zig
./hello
```
