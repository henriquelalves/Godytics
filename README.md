
# Godytics
Google Analytics for Godot Engine v2.1 stable and v3.0

Supported platforms;
- IOS
- Android

### Add module activation line to config file for android. (IOS auto enabled)

```
[android]
modules="org/godotengine/godot/Godytics"
```

### iOS: Add the following libraries and frameworks to the xcode project
![](http://i.imgur.com/hwpu7F2.png)

The last two are in this repository, under ios/lib.

### Add Analytics.gd GDScript (Singleton / Autoload Script) and define module initialization code in _ready() func

```
var godytics

func _ready():
  if(Globals.has_singleton("Godytics")):
    godytics = Globals.get_singleton("Godytics")
    godytics.init("UA-XXXXXXXX-X"); # Set Your TrackerId

func screen(name):
  if(Globals.has_singleton("Godytics")):
    godytics.screen(name)

func event(cat, action, label):
  if(Globals.has_singleton("Godytics")):
    godytics.event(cat, action, label)

```

How to define Singleton/Autoload script -> http://docs.godotengine.org/en/stable/tutorials/step_by_step/singletons_autoload.html

### Send Screen Hit

```
  Analytics.screen("Game")
```

### Sent Event Hit

```
  Analytics.event("Game", "LevelUp", "2")
```
