io.write("enter n: ")
n = io.read()
a = 1
b = 1
for i = 3,n do
    c = a + b
    a = b
    b = c
end
print(b)
