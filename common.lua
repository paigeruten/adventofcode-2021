function table.empty(t)
  return next(t) == nil
end

function table.inspect(t, level)
  level = level or 0
  local indent = string.rep("  ", level)

  local s = ""
  if level == 0 then s = s .. indent .. "{\n" end

  for k, v in pairs(t) do
    s = s .. indent .. "  "

    if type(k) == "string" and string.match(k, "%s") then
      s = s .. string.format("[%q]", k)
    elseif type(k) == "string" then
      s = s .. k
    else
      s = s .. "[" .. tostring(k) .. "]"
    end

    s = s .. " = "

    if type(v) == "table" and table.empty(v) then
      s = s .. "{}"
    elseif type(v) == "table" then
      s = s .. "{\n" .. table.inspect(v, level + 1) .. indent .. "  }"
    elseif type(v) == "string" then
      s = s .. string.format("%q", v)
    else
      s = s .. tostring(v)
    end

    s = s .. "\n"
  end

  if level == 0 then s = s .. indent .. "}\n" end

  return s
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
