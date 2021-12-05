function table.empty(t)
  return next(t) == nil
end

function table.inspect(t, level)
  level = level or 0
  local indent = string.rep("  ", level)

  local buf = {}
  if level == 0 then buf[#buf+1] = indent .. "{\n" end

  for k, v in pairs(t) do
    buf[#buf+1] = indent .. "  "

    if type(k) == "string" and string.match(k, "%s") then
      buf[#buf+1] = string.format("[%q]", k)
    elseif type(k) == "string" then
      buf[#buf+1] = k
    else
      buf[#buf+1] = "[" .. tostring(k) .. "]"
    end

    buf[#buf+1] = " = "

    if type(v) == "table" and table.empty(v) then
      buf[#buf+1] = "{}"
    elseif type(v) == "table" then
      buf[#buf+1] = "{\n"
      buf[#buf+1] = table.inspect(v, level + 1)
      buf[#buf+1] = indent .. "  }"
    elseif type(v) == "string" then
      buf[#buf+1] = string.format("%q", v)
    else
      buf[#buf+1] = tostring(v)
    end

    buf[#buf+1] = "\n"
  end

  if level == 0 then buf[#buf+1] = indent .. "}\n" end

  return table.concat(buf)
end

function table.print(t)
  io.stdout:write(table.inspect(t))
end

function table.partition(t, predicate)
  local yeses = {}
  local nos = {}
  for _, value in ipairs(t) do
    if predicate(value) then
      table.insert(yeses, value)
    else
      table.insert(nos, value)
    end
  end
  return yeses, nos
end
