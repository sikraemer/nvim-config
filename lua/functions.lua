local M = {}

M.os = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.os.capture = function(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

M.string = {}
M.string.concat = function(str1, str2)
  str1 = str1 .. str2
end

M.table = {}
-- Removes (and returns) a table element by its key,
-- moving down other elements to close space and
-- decrementing the size of the array
M.table.remove_key = function(table, key)
  local element = table[key]
  table[key] = nil
  return element
end

M.table.append_field = function(table, key, value)
  table[key] = table[key] .. value
end

M.table.prepend_field = function(table, key, value)
  table[key] = value .. table[key]
end

M.list = {}
M.list.contains_value = function(list, value)
  for _, v in pairs(list) do
    if v == value then
      return true
    end
  end
  return false
end

return M
