sum = 0
n = -1
a = 0
repeat
    sum = sum + a
    n = n + 1
    io.write("Enter number (enter end to quite): ")
    a = io.read()
until a == "end"
io.write("You have entered " .. n .. " numbers.\n")
io.write("sum = " .. sum .. "\n")
io.write("avg = " .. sum / n .. "\n")
