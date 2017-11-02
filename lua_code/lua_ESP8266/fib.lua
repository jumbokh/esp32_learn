function fib (n)
    local a = 1
    local b = 1
    for i = 3,n do
        local c = a + b
        a = b
        b = c
    end
    return b
end
