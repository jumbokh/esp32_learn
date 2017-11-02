spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, 8, 8)

-- initialize other spi slaves

-- then mount the sd
-- note: the card initialization process during `file.mount()` will set spi divider temporarily to 200 (400 kHz)
-- it's reverted back to the current user setting before `file.mount()` finishes
vol = file.mount("/SD0", 8)   -- 2nd parameter is optional for non-standard SS/CS pin
if not vol then
  print("retry mounting")
  vol = file.mount("/SD0", 8)
  if not vol then
    error("mount failed")
  end
end
file.open("/SD0/ld50/save.log")
--print(file.read())
for i = 1, 10 do
file.write("abcdefghijklmnopqrstuvwxyz")
end
file.close()