io.write("n = ? ")
n = io.read()
fac = 1
for i = 1,n do
  fac = fac * i
end
print(n .. "! = " .. fac)
