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
