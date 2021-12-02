local increases = 0
local window = {}
for num in io.lines("input", "*number") do
  if #window == 4 then
    table.remove(window)
  end
  table.insert(window, 1, num)

  if #window == 4 then
    window_sum = window[1] + window[2] + window[3]
    prev_window_sum = window[2] + window[3] + window[4]

    if window_sum > prev_window_sum then
      increases = increases + 1
    end
  end
end

print(increases)