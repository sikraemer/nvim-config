local nvim_lsp_sig = require('lsp_signature')

nvim_lsp_sig.setup({
  bind = true,
  always_trigger = true,
  extra_trigger_chars = {'(','{',','},
})
