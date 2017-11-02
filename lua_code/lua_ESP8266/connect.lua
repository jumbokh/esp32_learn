--nil
wifi.setmode(wifi.STATION);
wifi.start();
wifi.sta.config({ssid="informatics", pwd="0953313123"});
tmr.delay(10);
wifi.sta.connect();
info = wifi.sta.getconfig();
count = 0;
timeout = false;
while(string.len(info.ssid) == 0) do    -- wait for connection established
  tmr.delay(1);
  info = wifi.sta.getconfig();
  count = count + 1;
  if(count == 3) then 
    print("Connect timeout");
    timeout = true;
    break; 
  end
end