
## Functional Lua for Wildstar


### Overview
  `Lib:fun` is a port of [Roman Tsisyk's Functional Lua](https://github.com/rtsisyk/luafun/) library to [Wildstar.](wildstar-online.com) It enables the use of many common functions found in functional programming languages within Wildstar addons, such as `map`, `filter`, and `reduce`.

`Fun` is a small wrapper addon that provides an alternate method of access by wrapping all the functions into the Fun table and making it globally accessible.  This may be desirable for use  with `/eval`, the [GeminiConsole](https://github.com/wildstarnasa/GeminiConsole) in-game REPL, or for early addon development that uses `lib:fun`.  This avoids needing to load the lib manually in GeminiConsole, which helps with in-game testing and early development.  If it proves useful for the addon, `lib:fun` can then be included in the addon itself with minimal change to the code.

There is also a second file, fun-extra, that provides my own constructs for other FP-esque things I miss.  fun-extra contains the following:
* two variations on `(cond)`:  `cond` and `gen_cond`
* a functional `if` called `iff`
* `loop`, a function that works like `each`, but trades some flexibility for speed.

### Links

**lib:fun** on Curse:  http://www.curse.com/ws-addons/wildstar/237916-quest-tracker-tweaks<br>
**lib:fun** on GitHub:  https://github.com/Ilazki/ws-fun/<br>
**Luafun**  on GitHub:  https://github.com/rtsisyk/luafun/<br>
**Luafun** API docs:  https://rtsisyk.github.io/luafun/index.html<br>


### Usage

#####  Import all using `lib:fun` in an addon:
```lua
f = Apollo.GetPackage("lib:fun").tPackage
f.each(Print, f.range(3))
```

#####  Import specific functions from `lib:fun` in an addon:
```lua
ar = {'each', 'range'}
f  = Apollo.GetPackage("lib:fun").tPackage.import(ar)
f.each(Print, f.range(3))
```

#####  Using the global `Fun` addon (such as with GeminiConsole):
```lua
Fun.each(Print,Fun.range(3))     --- direct use
f = Fun                          --- binding to another name
f = Fun.import({'head', 'tail'}) --- binding specific functions from Fun
```



#####`_G` pollution of globals:

 **[BEWARE]**  Doing this affects **all addons** and is a really bad idea.  It's only listed for completeness.  Seriously, don't do this, especially in release code.
```lua
for k,v in pairs(Apollo.GetPackage("lib:fun").tPackage) do _G[k] = v end
each(Print, range(3))
```

