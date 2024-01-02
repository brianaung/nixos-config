# stuff I don't want to forget

To get the window class, use `xprop` and then grep the class property.
```
xprop | grep -i 'class'
```

Changing the display settings using `xrandr`.
```
xrandr --output=<name> <options>
```

Setting bg image using `feh`.
```
feh --bg-scale /path/to/image
```

Kill a process using its name.
```
pgrep <pname>
kill -9 <pid>
# or
pkill <pname>
```
