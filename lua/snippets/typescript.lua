local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local f = require('luasnip.extras').f
local fmt = require('luasnip.extras.fmt').fmt

local function camel_to_title(args)
  local var = args[1][1] or ''
  local words = var:gsub('([a-z])([A-Z])', '%1 %2')
  return words:sub(1, 1):upper() .. words:sub(2)
end

local function current_time()
  return os.date '%H:%M:%S'
end

local function line_number(_, snip)
  return tostring(snip.env.lnum)
end

local styles = {
  log = 'color: #7fbbb3; font-weight: bold;',
  warn = 'color: #e6c384; font-style: italic;',
  error = 'color: #e46876; font-weight: bold; text-decoration: underline;',
  info = 'color: #b4f9f8;',
}

return {
  s(
    'log',
    fmt(
      [[
console.log(
  "%c[{}] [Line {}] {}:",
  "{}",
  {}
);
]],
      {
        f(current_time),
        f(line_number),
        f(camel_to_title, { 1 }),
        styles.log,
        i(1, 'variable'),
      }
    )
  ),

  s(
    'warn',
    fmt(
      [[
console.warn(
  "%c[{}] [Line {}] Warning {}:",
  "{}",
  {}
);
]],
      {
        f(current_time),
        f(line_number),
        f(camel_to_title, { 1 }),
        styles.warn,
        i(1, 'variable'),
      }
    )
  ),

  s(
    'error',
    fmt(
      [[
console.error(
  "%c[{}] [Line {}] Error {}:",
  "{}",
  {}
);
]],
      {
        f(current_time),
        f(line_number),
        f(camel_to_title, { 1 }),
        styles.error,
        i(1, 'variable'),
      }
    )
  ),

  s(
    'info',
    fmt(
      [[
console.info(
  "%c[{}] [Line {}] Info {}:",
  "{}",
  {}
);
]],
      {
        f(current_time),
        f(line_number),
        f(camel_to_title, { 1 }),
        styles.info,
        i(1, 'variable'),
      }
    )
  ),
}
