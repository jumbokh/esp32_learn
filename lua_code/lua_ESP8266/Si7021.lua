starttime = tmr.now()
-- setup Wifi only once after power cycle
local val = rtcmem.read32(0)
if val ~= 32767 then
  wifi.setmode(wifi.STATION)
  wifi.setphymode(wifi.PHYMODE_N)
  wifi.sta.config("<SSID>", "<password>3")
  -- save more power by using static IP instead of DHCP
  wifi.sta.setip({ip="<my ip>",netmask="255.255.255.0",gateway="<my gw ip>"})
  wifi.sta.connect()
  
  rtcmem.write32(0,32767)
end

-- read AM3220 / Si7021 on GPIO2/0 = Pin 4 / 3 - 
sda_pin = 4
scl_pin = 3
si7021 = require("si7021")
si7021.init(sda_pin, scl_pin)
si7021.read(status)

wifi.sta.status()
--print(wifi.sta.getip())


-- Deep sleep time in ms (300s)
deepsleep_time = 300000

local sensor = "mobile"
local host_ip = "<receiving host ip>"

function loop() 
  if wifi.sta.status() == 5 then
    -- Stop the wifi connection wait-loop
    tmr.stop(0)
    
    conn=net.createConnection(net.TCP, 0) 
    conn:on("receive", function(conn, payload)
--      print(payload);
    end) 
    conn:connect(80,host_ip)
    conn:on("connection", function(conn, payload)
--      print("Connected")
      -- read battery voltage
      local vbat = 5.555*(adc.read(0)/1024)
      local humi = si7021.getHumidity()
      local temp = si7021.getTemperature()
--        buf = temp.."\n"..humi.."\n"
      local my_table = {}
      my_table[#my_table + 1]="GET /send.py?sensor="
      my_table[#my_table + 1]=sensor
      my_table[#my_table + 1]="&temp="
      my_table[#my_table + 1]=string.format("%.2f",(temp/100))
      my_table[#my_table + 1]="&hum="
      my_table[#my_table + 1]=string.format("%.2f",(humi/100))
      my_table[#my_table + 1]="&vbat="
      my_table[#my_table + 1]=string.format("%.3f",vbat)
      my_table[#my_table + 1]="&time="
      my_table[#my_table + 1]=string.format("%.3f",((tmr.now() - starttime) / 1000000))
      my_table[#my_table + 1]=" HTTP/1.1\r\nHost: "
      my_table[#my_table + 1]=host_ip
      my_table[#my_table + 1]="\r\nAccept: */*\r\n" 
      my_table[#my_table + 1]="User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n\r\n"
      local my_string=table.concat(my_table)
      conn:send(my_string)
    end)
    conn:on("disconnection", function(conn, payload)
--      print('Disconnected') 
      conn:close()
--      print(buf)
--      collectgarbage()
--    print("Going to deep sleep for "..(deepsleep_time/1000).." seconds")
      node.dsleep(deepsleep_time*1000)
    end)
  else
--    print("Waiting for Wifi ...")
  end
end

tmr.alarm(0, 100, 1, function() loop() end)

-- Watchdog loop, will force deep sleep if the operation somehow takes to long
tmr.alarm(1,15000,1,function() node.dsleep(deepsleep_time*1000) end)
-- eof - See more at: http://www.esp8266.com/viewtopic.php?f=24&t=11057#sthash.kkdR3YaW.dpuf
