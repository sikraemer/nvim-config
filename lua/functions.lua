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

M.table = {}
-- Removes (and returns) a table element by its key,
-- moving down other elements to close space and
-- decrementing the size of the array
M.table.remove_key = function(table, key)
    local element = table[key]
    table[key] = nil
    return element
end

return M
