print("\n")
print("LuaNode Started")
     
local luaFile = {"fileName.lua"}
 for i, f in ipairs(luaFile) do
   if file.open(f) then
      file.close()
      print("Compile File:"..f)
      node.compile(f)
      print("Remove File:"..f)
      file.remove(f)
    end
 end

f1 = function()
 pwm.setup(2, 1, 4096, 0); -- blink per seconds
 duty=pwm.getduty(0);
 print(duty);
 freq = pwm.getfreq();
 print(freq);      
 tmr.delay(1);
 pwm.stop(0);
end
     
 luaFile = nil
 collectgarbage()
 start(f1);
 --thread.start(f1);
 
 --tmr.delay(10);
 --pwm.setfreq(2); -- blink twice per seconds
 --tmr.delay(10);
 --pwm.stop(0);
 --dofile("base.lua");

