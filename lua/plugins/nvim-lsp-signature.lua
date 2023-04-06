local nvim_lsp_sig = require('lsp_signature')

nvim_lsp_sig.setup({
  bind = true,
  doc_lines = 10,
  handler_opts = {
    border = "none"
  },
  extra_trigger_chars = {'(','{',','},
})
