# 📡 live-server.nvim :  Use the power of [live-server](https://www.npmjs.com/package/live-server) from NPM inside Neovim

## ⚡️ Requirements

- Node.js package manager
- [noice](https://github.com/folke/noice.nvim) : notification view _**(optional)**_
- [Nerd Font](https://www.nerdfonts.com/) **_(optional)_**

## 📦 Installation
1. Install [live-server](https://www.npmjs.com/package/live-server) globally with your node.js package manager of choice.

2. Install the plugin with your preferred neovim plugin manager:

For example, a config with [npm](https://www.npmjs.com/) and [lazy.nvim](https://github.com/folke/lazy.nvim) may look like the following:
```lua
{
  "d-vegapunk/live-server.nvim",
  event = "VeryLazy",
  build = 'npm install -g live-server'
  config = function()
    require('live-server').setup{}
  end
}
```

## ⚙️ Configuration

### 🎨 Example configurations: 
```lua
require('live-server').setup{
    liveserver_args = {
        "--port=3621",
        "--no-css-inject"
    },
}
```
(See [live-server](https://github.com/tapio/live-server#usage-from-command-line) for more `liveserver_args` information)

## 🚀 Usage

- `:LiveServerStart` start the live-server
- `:LiveServerStop` stop the live-server
- `:LiveServerToggle` toggle the live-server

## Special Thanks
- 🤟 [this plugin](https://github.com/d-vegapunk/live-server.nvim) - a fork of ⤵️
    -  💯 [barrett-ruth/live-server.nvim](https://github.com/barrett-ruth/live-server.nvim) - an awesome fork of ⤵️
        - 💥 [aurum77/live-server.nvim](https://github.com/aurum77/live-server.nvim) - the first live-server port to neovim.