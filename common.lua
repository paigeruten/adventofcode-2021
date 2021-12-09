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

function string.tsplit(str, pattern)
  if str == "" then return {} end

  pattern = pattern or "%s+"

  if pattern == "" then
    local parts = {}
    for char in string.gmatch(str, ".") do
      table.insert(parts, char)
    end
    return parts
  end

  local parts = {}
  local index = 1
  while true do
    if index > #str then
      table.insert(parts, "")
      break
    end

    local i, j = string.find(str, pattern, index)

    if not i then
      table.insert(parts, string.sub(str, index))
      break
    end

    if i == index then
      table.insert(parts, "")
    else
      table.insert(parts, string.sub(str, index, i - 1))
    end

    index = j + 1
  end

  return parts
end

function string.split(str, pattern)
  return table.unpack(string.tsplit(str, pattern))
end

function string.scan(str, pattern)
  local matches = {}
  for match in string.gmatch(str, pattern) do
    table.insert(matches, match)
  end
  return matches
end