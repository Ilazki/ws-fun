-------------------------------------------------------------------------------
---
---                        FUNCTIONAL LUA FOR WILDSTAR
---                 Copyright (c) Ilazki. All rights reserved
---           Ported by Ilazki, original fun.lua lib by Roman Tsisyk
---
---  `Lib:fun` is a port of Roman Tsisyk's Functional Lua library to Wildstar.
---  It enables the use of many common functions found in functional programming
---  languages within Wildstar addons, such as `map`, `filter`, and `reduce`.
---
---  `Fun` is a small wrapper addon that provides an alternate method of access
---  by wrapping all the functions into the Fun table and making it globally
---  accessible.  This may be desirable for use  with `/eval`, the GeminiConsole
---  in-game REPL, or for early addon development that uses `lib:fun`.  This
---  avoids needing to load the lib manually in GeminiConsole, which helps with
---  in-game testing and early development.  If it proves useful for the addon,
---  lib:fun can then be included in the addon itself with minimal change to the
---  code.
---
---  This file is unnecessary when using lib:fun in an addon.  Instead, use the
---  included lib/luafun.lua file and the standard method of accessing your lib
---  by adding it to toc.xml and  `fun = Apollo.GetPackage("lib:fun").tPackage`
---  to your addon.
---
---
---  VERSION         :  1.0
---  lib:fun Curse   :  N/A                          TODO: set up curse project
---  lib:fun Github  :  https://github.com/Ilazki/ws-fun/
---  Luafun github   :  https://github.com/rtsisyk/luafun/
---  Luafun API docs :  https://rtsisyk.github.io/luafun/index.html
---
---
---  USAGE
---
---  Import all using lib:fun in an addon:
---    f = Apollo.GetPackage("lib:fun").tPackage
---    f.each(Print, f.range(3))
---
---  Import specific functions from lib:fun in an addon:
---    ar = {'each', 'range'}
---    f  = Apollo.GetPackage("lib:fun").tPackage.import(ar)
---    f.each(Print, f.range(3))
---
---  Using the global Fun addon (such as with GeminiConsole):
---    Fun.each(Print,Fun.range(3))     --- direct use
---    f = Fun                          --- binding to another name
---    f = Fun.import({'head', 'tail'}) --- binding specific functions from Fun
---
---
---
---  For completeness, _G pollution of globals:
---  !!!! BEWARE !!!!
---  Doing this affects ALL ADDONS and is a really bad idea.  It's only listed
---  for completeness.  Seriously, don't do this, especially in release code.
---
---    for k,v in pairs(Apollo.GetPackage("lib:fun").tPackage do _G[k] = v end
---    each(Print, range(3))
---
-------------------------------------------------------------------------------

require "Apollo"

Fun = {}

-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------
function Fun:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  -- initialize variables here
  self.tSavedVariables = {}

  -- Populate with luafun functions.
  for k,v in pairs(Apollo.GetPackage("lib:fun").tPackage) do self[k] = v end

  return o
end

function Fun:Init()
	local bHasConfigureFunction = false
	local strConfigureButtonText = ""
	local tDependencies = {
	}
  Apollo.RegisterAddon(self, bHasConfigureFunction, strConfigureButtonText, tDependencies)
end


function Fun:OnLoad()
-- has to exist; doesn't need to do anything.
end

-------------------------------------------------------------------------------
-- Instantiation
-------------------------------------------------------------------------------
local FunInst = Fun:new()
FunInst:Init()
