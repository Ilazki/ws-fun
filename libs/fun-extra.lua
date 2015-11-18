---------------------
--- WSLib setup stuff
---------------------

require "Apollo"
local MAJOR,MINOR = "lib:fun-extra",1
local aPkg = Apollo.GetPackage(MAJOR)
if aPkg and (aPkg.nVersion or 0) >= MINOR then return end
local libFE = aPkg and aPkg.tPackage or {}

-------------
--- Functions
-------------

-- This generates an anonymous function of chained if/ifelse/else statements created
--  from the string arguments passed to it in form of "condition","expression" pairs.
--  That function should be saved to a variable and then later called when the actual
--  check is needed.
--
-- Caveats:
--  1) it won't have access to any locals, so you have to briefly set globals before use
--  2) it's really slow to generate but the resulting funciton is fast.  Have to plan it.
--
-- The idea is to generate the condition in advance and then use the generated function
-- where there's a performance bottleneck.
--
-- USAGE:  my_cond = gen_cond("condition", "expression", ...)

local function gen_cond(...)
   arg = {...}
   s = 'if nil then return \n' -- Always fails into the generated code. Simplifies generation
   for i=1,#arg,2 do
	  local test = arg[i]
	  local expr = arg[i+1]
	  s = s .. string.format("elseif %s then %s \n", test, expr)
   end
   s = s .. "end"
   return loadstring(s)
end

-- A more correct implementation than GEN_COND, but at the cost of performance.
--  It runs ~0.5s per 300k iterations of a six condition test, vs. ~0.25s for an
--  if/elseif/else (via gen_cond)
--
-- Unlike gen_cond, works more FP-like and takes a function for the expr and 
-- can take any sort of condition or function for the condition portion.
--
-- Should be fast enough to use in most situations, and then replaced with a
-- saved gen_cond where a bottleneck is found.
--
-- USAGE:  cond(condition, function() ... end, ...)
local function cond(...)
   local arg = {...}
   for i=1,#arg,2 do
	  if arg[i] then return arg[i+1]() end
   end
end

------------------
--- Set up exports
------------------
libFE.cond     = cond
libFE.gen_cond = gen_cond


--------------------
--- Register the lib
--------------------

Apollo.RegisterPackage(libFE, MAJOR, MINOR, {})

