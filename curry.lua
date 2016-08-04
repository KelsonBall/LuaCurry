function curry(func, params)        
    return (function (...)
        local args = params or {}        
        if #args + #{...} == debug.getinfo(func).nparams then
            local args = {table.unpack(args)}
            for _,v in ipairs({...}) do
                table.insert(args, v)
            end
            return func(table.unpack(args))
        else
            local args = {table.unpack(args)}
            for _,v in ipairs({...}) do
                table.insert(args, v)
            end
            return curry(func, args)
        end
    end)
end

add = curry(function (a, b, c)    
  return a + b + c
end)

print( "Testing" )

assert( add(1)(2)(3) == 6 )

assert( add(1)(1)(1) == 3 )

local add2 = add(0)(2)

assert( add2(3) == 5 ) -- 5

assert( add2(4) == 6 ) -- 3

sum = curry(function(a, group)
    for _,v in ipairs(group) do
      a = a + v
    end
    return a
end)

local sumWith0 = sum(0)

assert( sumWith0({1, 2, 3}) == 6)

assert( sumWith0({2, 3, 4}) == 9 )

assert( sum(1)({2, 3}) == 6 )

print( "Complete" )
