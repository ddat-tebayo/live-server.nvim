# 📡 live-server.nvim

## ✨ Features
- 📡 Use the power of [live-server](https://www.npmjs.com/package/live-server) from NPM inside Neovim
- 🚥 **lualine component** : show live-server's connection status icon (click to toggle live-server).

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

## 🚥 Using live-server as a component in lualine :
- *⚠️ In order to display the live-server connection status icon in lualine, you must add the component to one of your lualine sections :*
```lua
-- lualine.nvim

require("lualine").setup {
    ...
    sections = {
        lualine_y = {
            'another_component',
            ...,
            require('live-server.integration.lualine')
        }
    }
}
```
- *and add your **live-server.nvim** configs or use the defaults with no arguments*
```lua
-- live-server.nvim
-- "no arguments": come with the following defaults:
 
require('live-server').setup{
    liveserver_args = {},
    integration = {
        lualine = {
            supported_filetypes = {"html", "css", "javascript", "javascriptreact"},
            icons = {
                disconnected = "󰄙",
                connected = "󰄙"
            },
            colors = {
                disconnected = "#559dd7", --blue
                connected = "#00c234" --green
            }
        }
    }
}
```

## 🚀 Usage

- `:LiveServerStart` start the live-server
- `:LiveServerStop` stop the live-server
- `:LiveServerToggle` toggle the live-server

Alternatively, you can also toggle live-server via clickable icon in lualine if you have [configured it](#-example-of-using-live-server-as-a-custom-component-in-lualine-).

## 🎯 Goal(s)
- The updated [bracey.vim](https://github.com/turbio/bracey.vim) for Neovim, written in Lua, that truly fits with the name `live`.

## 📌 Special Thanks
- 🤟 [this plugin](https://github.com/d-vegapunk/live-server.nvim) - a fork of ⤵️
    -  💯 [barrett-ruth/live-server.nvim](https://github.com/barrett-ruth/live-server.nvim) - a groundbreaking advancement from ⤵️
        - 💥 [aurum77/live-server.nvim](https://github.com/aurum77/live-server.nvim) - a plugin to integrate live-server into Neovim.