-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- telescope 이 기본이나 fzf 을 사용하기 위해 LazyExtra 에서
-- fzf 설치후 아래 설정을 추가하여 fzf 으로 설정
-- then you need to set the option below.
-- vim.g.lazyvim_picker = "fzf"

-- python env from conda
local function isempty(s)
  return s == nil or s == ""
end
local function use_if_defined(val, fallback)
  return val ~= nil and val or fallback
end
local conda_prefix = vim.env.CONDA_PREFIX
if not isempty(conda_prefix) and string.find(conda_prefix, "envs") ~= nil then
  vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, conda_prefix .. "/bin/python")
  vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, conda_prefix .. "/bin/python3")
else
  vim.g.python_host_prog = "/opt/homebrew/Caskroom/miniconda/base/envs/pynvim/bin/python"
  vim.g.python3_host_prog = "/opt/homebrew/Caskroom/miniconda/base/envs/pynvim/bin/python3"
  -- vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, "python")
  -- vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, "python3")
end
-- vim.g.python.pythonPath = vim.g.python_host_prog

-- Enable pbcopy in tmux in MacOS
vim.g.clipboard = {
  name = 'macos+tmux',
  copy = {
    ['+'] = { 'pbcopy' },
    ['*'] = { 'tmux', 'load-buffer', '-' },
  },
  paste = {
    ['+'] = { 'pbpaste' },
    ['*'] = { 'tmux', 'save-buffer', '-' },
  },
  cache_enabled = 0,
}
