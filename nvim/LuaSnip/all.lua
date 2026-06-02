local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

-- (Paste the snippets above here)
return {
  -- bm2x1: 2x1 bmatrix
  s(
    'bm2x1',
    fmt(
      [[
\begin{{bmatrix}}
  {} \\
  {}
\end{{bmatrix}}
]],
      { i(1), i(2) }
    )
  ),

  -- bm2x2: 2x2 bmatrix
  s(
    'bm2x2',
    fmt(
      [[
\begin{{bmatrix}}
  {} & {} \\
  {} & {}
\end{{bmatrix}}
]],
      { i(1), i(2), i(3), i(4) }
    )
  ),

  -- bm3x3: 3x3 bmatrix
  s(
    'bm3x3',
    fmt(
      [[
\begin{{bmatrix}}
  {} & {} & {} \\
  {} & {} & {} \\
  {} & {} & {}
\end{{bmatrix}}
]],
      { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9) }
    )
  ),

  -- aug2x2: 2x2 augmented bmatrix
  s(
    'aug2x2',
    fmt(
      [[
\left[
\begin{{array}}{{cc|c}}
  {} & {} & {} \\
  {} & {} & {}
\end{{array}}
\right]
]],
      { i(1), i(2), i(3), i(4), i(5), i(6) }
    )
  ),

  -- aug3x3: 3x3 augmented bmatrix
  s(
    'aug3x3',
    fmt(
      [[
\left[
\begin{{array}}{{ccc|c}}
  {} & {} & {} & {} \\
  {} & {} & {} & {} \\
  {} & {} & {} & {}
\end{{array}}
\right]
]],
      { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9), i(10), i(11), i(12) }
    )
  ),
  s('dm', {
    t { '\\[', '' },
    i(1),
    t { '', '\\]' },
  }),
  s('mm', {
    t { '$$' },
    i(1),
    t { '$$' },
  }),
}
