local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
local fortune = require 'alpha.fortune'

-- 🎨 Заголовок (можна змінити на будь-який ASCII)
dashboard.section.header.val = {
  [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
  [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
  [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
  [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
  [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
  [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
}

-- 🔘 Кнопки
dashboard.section.buttons.val = {
  dashboard.button('f', '󰈞  Find File', ':Telescope find_files<CR>'),
  dashboard.button('r', '  Recent Files', ':Telescope oldfiles<CR>'),
  dashboard.button('n', '  New File', ':ene <BAR> startinsert <CR>'),
  dashboard.button('s', '  Colorscheme', ':Telescope colorscheme<CR>'),
  dashboard.button('l', '󰒲  Lazy', ':Lazy<CR>'),
  dashboard.button('q', '  Quit', ':qa<CR>'),
}

-- 🧠 Footer: система, дата або цитата
dashboard.section.footer.val = fortune()

-- 🎨 Стилі
dashboard.section.header.opts.hl = 'AlphaHeader'
dashboard.section.buttons.opts.hl = 'AlphaButtons'
dashboard.section.footer.opts.hl = 'AlphaFooter'

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
