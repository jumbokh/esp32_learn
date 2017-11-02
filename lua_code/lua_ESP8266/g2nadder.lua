io.write("Input n: ")
n = io.read()
io.write("Enter " .. n .. " numbers:\n")
sum = 0
for i = 1,n do
    a = io.read()
    if a == "end" then
       n = i - 1
       break
    end
    sum = sum + a
end
io.write("sum = " .. sum .. "\n")
io.write("avg = " .. sum / n .. "\n")
