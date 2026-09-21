-- ==============================================================================
-- ⚡ XVIMTUTOR - Complete Interactive Vim Curriculum (English)
-- ==============================================================================

local M = {}

M.lessons = {
  {
    id = 1,
    title = "Lesson 1: Basic Movement (h, j, k, l)",
    subtitle = "Forget the arrow keys on your keyboard",
    instructions = [[
Welcome to XVimTutor!
In Vim, your fingers never need to leave the home row.
Arrow keys slow you down. Use these keys instead:

        ^
        k
  < h       l >
        j
        v

  h — Move Left
  j — Move Down
  k — Move Up
  l — Move Right

────────────────────────────────────────────────────────────────────────────
[ EXERCISE 1 ]
Move your cursor using h, j, k, l to each target star '★' below.
Do not use the arrow keys!

    Line 1: .................. ★ (reach this star)
    Line 2: ....... ★ ........ (now here)
    Line 3: ★ ................ (and to the start)

When comfortable, press <leader>tn for the next lesson!
]],
    check_line = "Line 3: ★",
  },
  {
    id = 2,
    title = "Lesson 2: Fast Word Jumps (w, b, e, 0, $, gg, G)",
    subtitle = "Navigate at the speed of thought",
    instructions = [[
Moving character-by-character is too slow. Use jumps:

  w  — Jump forward to the start of the next word
  b  — Jump backward to the start of the previous word
  e  — Jump forward to the end of the current word
  0  — Jump to the very beginning of the line
  $  — Jump to the very end of the line
  gg — Jump to the first line of the file
  G  — Jump to the last line of the file

────────────────────────────────────────────────────────────────────────────
[ EXERCISE 2 ]
1. Position your cursor at the start of this line and press 'w' to hop through words.
2. Press '$' to jump instantly to the end of the line.
3. Press '0' to return to the beginning.
4. Press 'b' to jump backward word by word.

Test line: const performanceMetric = calculateZeroLatencySpeed();
]],
    check_line = "calculateZeroLatencySpeed",
  },
  {
    id = 3,
    title = "Lesson 3: Insert Mode & Editing (i, a, o, O, x, u, <C-r>)",
    subtitle = "Switching between Normal and Insert modes",
    instructions = [[
Vim is modal. Normal mode is for issuing commands, Insert is for writing text.

  i     — Enter Insert mode BEFORE the cursor
  a     — Enter Insert mode AFTER the cursor (append)
  o     — Open a new line BELOW and enter Insert mode
  O     — Open a new line ABOVE and enter Insert mode
  x     — Delete the character under the cursor
  u     — Undo the last change
  Ctrl-r— Redo the undone change
  <Esc> — Return to Normal mode (CRITICAL!)

────────────────────────────────────────────────────────────────────────────
[ EXERCISE 3 ]
1. Fix the typo in the line below: delete the extra 'x' using 'x'.
2. Press 'A' (Shift+a) to jump to the line end and append: " [DONE]".
3. Press <Esc> to return to Normal mode!

Line to fix: const speed = "20mxs";
]],
    target_match = 'const speed = "20ms"; [DONE]',
  },
  {
    id = 4,
    title = "Lesson 4: Vim Grammar: Operators + Motions (d, c, y, p)",
    subtitle = "Command syntax: Verb + Noun",
    instructions = [[
Vim commands work like sentences: [OPERATOR] + [MOTION / COUNT].

Operators (Verbs):
  d  — Delete / cut
  c  — Change: delete and immediately enter Insert mode
  y  — Yank / copy
  p  — Put / paste after cursor

Combinations:
  dw — Delete word forward
  de — Delete to the end of word
  cw — Change word (deletes word and enters Insert)
  dd — Delete (cut) the ENTIRE line!
  yy — Yank (copy) the ENTIRE line
  cc — Clear the line and start typing
  3dd— Delete 3 lines at once

────────────────────────────────────────────────────────────────────────────
[ EXERCISE 4 ]
1. Delete the extra word "ERROR_BUG" using 'dw' or 'de'.
2. Copy the variable line (yy) and paste it below using 'p'.

Line: function processData() { delete ERROR_BUG token; }
]],
    target_match = "function processData() { delete token; }",
  },
  {
    id = 5,
    title = "Lesson 5: Superpower of Text Objects (ciw, ca\", ci(, di{)",
    subtitle = "Surgical precision without manual highlighting",
    instructions = [[
This is Vim's standout superpower:
Formula: [OPERATOR: c/d/y] + [i(inside) or a(around)] + [OBJECT]

  ciw — Change inside word (anywhere cursor is located!)
  diw — Delete inside word
  ci" — Change everything inside quotes "..."
  ca" — Change everything including quotes "..."
  ci( or cib — Change everything inside parentheses (...)
  di{ or diB — Delete entire function/block body inside { ... }
  yi( — Copy arguments inside parentheses

────────────────────────────────────────────────────────────────────────────
[ EXERCISE 5 ]
Place your cursor anywhere inside the quotes below and press: ci"
Then type: zero-latency
Press <Esc>.

Source code: const title = "slow-and-old-editor";
]],
    target_match = 'const title = "zero-latency";',
  },
  {
    id = 6,
    title = "Lesson 6: Visual Mode & Block Editing (v, V, <C-v>)",
    subtitle = "Block selections and multi-line editing without a mouse",
    instructions = [[
Visual mode allows precise text selection:

  v      — Character-wise selection
  V      — Line-wise selection
  Ctrl-v — COLUMN BLOCK SELECTION!

How to comment multiple lines at once:
  1. Move to the beginning of the first line.
  2. Press Ctrl-v.
  3. Press j, j to expand selection down across 3 lines.
  4. Press Shift-I (I for insert at block start).
  5. Type "// " and press <Esc> — all lines are commented simultaneously!

────────────────────────────────────────────────────────────────────────────
[ EXERCISE 6 ]
Comment these 3 lines simultaneously using Ctrl-v + j + j + Shift-I + "// " + <Esc>:

const a = 1;
const b = 2;
const c = 3;
]],
    target_match = "// const a = 1;",
  },
  {
    id = 7,
    title = "Lesson 7: Instant Search & Replace (/, ?, n, N, :%s)",
    subtitle = "Regex and project-wide substitutions",
    instructions = [[
Search:
  /query  — Search forward. Press Enter to navigate.
  ?query  — Search backward.
  n       — Jump to next match
  N       — Jump to previous match
  *       — Instantly search word under cursor forward!
  #       — Instantly search word under cursor backward!

Substitute:
  :s/old/new/g   — Replace in current line
  :%s/old/new/g  — Replace across the ENTIRE file
  :%s/old/new/gc — Replace with confirmation for each occurrence (y/n)

────────────────────────────────────────────────────────────────────────────
[ EXERCISE 7 ]
Replace 'var' with 'const' in the line below:
Position on line and run:  :s/var/const/g  and press Enter.

var username = "nickolay";
]],
    target_match = 'const username = "nickolay";',
  },
  {
    id = 8,
    title = "Lesson 8: XVim Superpowers",
    subtitle = "Modern tools built into your editor",
    instructions = [[
XVim comes preconfigured with high-speed superpowers:

1. Flash Navigation ('s'):
   - Press 's', then type any 2 characters on screen.
   - Jump labels appear — press the highlighted key to land there instantly!

2. Fast File & Text Search (Snacks Picker):
   - <Space> <Space> or <Space> f f — Instant file finder across project.
   - <Space> /       or <Space> s g — Live grep text across all files.
   - <Space> f r                     — Recent files.

3. File Explorer:
   - <Space> e — Toggle the high-speed sidebar explorer.

4. Window Management & Splits:
   - <Space> | — Split window vertically.
   - <Space> - — Split window horizontally.
   - Ctrl-h / Ctrl-j / Ctrl-k / Ctrl-l — Switch between split windows.
   - <Space> w — Save file.
   - <Space> q — Close window.

5. Code Diagnostics:
   - <Space> x x — Toggle Trouble (diagnostics and errors panel).

────────────────────────────────────────────────────────────────────────────
Congratulations! You have mastered the fundamentals of XVim.
Press <leader>tc for final verification, or <leader>tq to start coding!
]],
    check_line = "Congratulations!",
  },
}

return M
