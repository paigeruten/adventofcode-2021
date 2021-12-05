dofile("common.lua")

return {
  table_is_empty = function()
    assert(is_true(table.empty({})))
  end,
  table_is_not_empty = function()
    assert(is_false(table.empty({42})))
  end,
  table_is_not_empty_even_with_false_key = function()
    assert(is_false(table.empty({[false] = false})))
  end,

  table_partition = function()
    local is_even = function(x) return x % 2 == 0 end
    local evens, odds = table.partition({1, 2, 3, 4, 5}, is_even)

    assert(table_equals({2, 4}, evens))
    assert(table_equals({1, 3, 5}, odds))
  end,
}
