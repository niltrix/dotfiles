return {
  {
  'linux-cultist/venv-selector.nvim',

    branch = "regexp", -- Use this branch for the new version
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      -- Your options go here
      settings = {
        search = {
          anaconda_base = {
            command = "fd 'python$' /opt/homebrew/Caskroom/miniconda/base/bin --full-path --color never -E /proc",
            type = "anaconda",
          },
          anaconda_envs = {
            command = "fd 'python$' /opt/homebrew/Caskroom/miniconda/base/envs --full-path --color never -E /proc",
            type = "anaconda",
          },
        },
        options = {
          name = "anaconda",
          anaconda_base_path = '/opt/homebrew/Caskroom/miniconda/base',
          anaconda_envs_path = '/opt/homebrew/Caskroom/miniconda/base/envs',
          notify_user_on_venv_activation = true,
        },
      },
    },
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    ft = "python",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
   },
}
