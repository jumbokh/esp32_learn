io.write("Enter numbers (enter end to quit):\n")
sum = 0
n = 0
a = io.read()
while a ~= "end" do
    sum = sum + a
    n = n + 1
    a = io.read()
end
io.write("You have entered " .. n .. " numbers.\n")
io.write("sum = " .. sum .. "\n")
io.write("avg = " .. sum / n .. "\n")
