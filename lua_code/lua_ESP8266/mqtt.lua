-- Connect to Wifi AP
wifi.setmode(wifi.STATION)
wifi.sta.config("informatics","0953313123")

-- init mqtt client with keepalive timer 120sec
m = mqtt.Client("notemcu", 120, "", "")

-- setup Last Will and Testament (optional)
-- Broker will publish a message with:
-- qos = 0, retain = 0, data = "offline" 
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("/lwt", "offline", 0, 0)

m:on("connect", function(con) print ("connected") end)
m:on("offline", function(con) print ("offline") end)
-- on publish message receive event
m:on("message", function(conn, topic, data) 
  print(topic .. ":" ) 
  if data ~= nil then
    print("message=&gt;", data)
  end
end)
