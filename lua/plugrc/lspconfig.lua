local lsp=require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;
lsp.clangd.setup{
cmd =
{ "clangd", "--query-driver=/usr/bin/g++","--clang-tidy","-j=5","--malloc-trim" },
capabilities=capabilities;
filetypes = { "c", "cpp"},
  --  on_init = function to handle changing offsetEncoding
root_dir = lsp.util.root_pattern("compile_commands.json", ".git"),
}

lsp.hls.setup{capabilities=capabilities;}
require'lspconfig'.zls.setup
{
    cmd={"zls"},
    filetypes = {"zig","zir"},
    capabilities=capabilities;
    root_dir = lsp.util.root_pattern("zls.json", ".git")
}
require('lspsaga').init_lsp_saga()
 cfg = {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 9, -- will show two lines of comment/doc
                 --(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode,
    -- it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window,
    --set to false for virtual text only mode
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  hi_parameter = "Search", -- how your parameter will be highlight
  max_height = 18, -- max height of signature floating_window,
    --if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window,
    --line will be wrapped if exceed max_width
  handler_opts = {
    border = "single"   -- double, single, shadow, none
  },
}

require'lsp_signature'.on_attach(cfg)