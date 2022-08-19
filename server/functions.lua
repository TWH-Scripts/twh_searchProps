function switch(c)
    local swtbl = {
      casevar = c,
      caseof = function (self, code)
        local f
        if (self.casevar) then
          f = code[self.casevar] or code.default
        else
          f = code.missing or code.default
        end
        if f then
          if type(f)=="function" then
            return f(self.casevar,self)
          else
            error("case "..tostring(self.casevar).." not a function")
          end
        end
      end
    }
    return swtbl
  end

  function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1 ^ 2
    local t2 = y - cy
    local t21 = t2 ^ 2
    local t3 = z - cz
    local t31 = t3 ^ 2
    return (t12 + t21 + t31) <= radius ^ 1
end