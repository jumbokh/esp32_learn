-- timer
-- tmr.delay(us) 
start1=tmr.now();
print(start1); -- Output timestamp
tmr.delay_us(1000000);  -- Delay 1000000us, and then output hello
print("hello");

tmr.delay_ms(1000);        -- delay 1000ms
print("hello");

tmr.delay(1);           -- delay 1s
print("hello");
end1=tmr.now();
print(end1);
print(end1-start1); -- Output timestamp
