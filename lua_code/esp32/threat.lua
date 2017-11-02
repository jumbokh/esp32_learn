-- Thread test
-- Start a thread for LED blinking
-- Print status of the thread

f1=function()
  pwm.setup(2, 1, 4096, 0); -- blink per seconds
  duty=pwm.getduty(0);
  print(duty);
  freq = pwm.getfreq();
  print(freq);
  while true do      
    tmr.delay(10);
    pwm.setfreq(2); -- blink twice per seconds
    tmr.delay(10);
    pwm.stop(0);
  end
end

th1=thread.start(f1);
status = thread.status(th1);  -- get thread status, and then print it
print(status);    -- this will output running
--status = thread.stop(th1);
--print(status);