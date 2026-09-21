-- ==============================================================================
-- ⚡ XVIMTUTOR - Interactive Vim & XVim Mastery Engine (RU / EN)
-- ==============================================================================

local M = {}
local lang = require("xvim.config.lang")

M.current_idx = 1
M.buf = nil
M.win = nil

local function get_lessons()
  if lang.current == "en" then
    return require("xvim.tutor.lessons_en").lessons
  else
    return require("xvim.tutor.lessons").lessons
  end
end

local function notify(msg, level)
  level = level or vim.log.levels.INFO
  if Snacks and Snacks.notifier then
    Snacks.notifier.notify(msg, level, { title = "XVimTutor ⚡" })
  else
    vim.notify("⚡ [XVimTutor] " .. msg, level)
  end
end

function M.render_lesson(idx)
  M.current_idx = idx
  local lessons = get_lessons()
  local lesson = lessons[idx]
  if not lesson then
    notify("Lesson #" .. idx .. " not found", vim.log.levels.ERROR)
    return
  end

  -- Prepare buffer
  if not M.buf or not vim.api.nvim_buf_is_valid(M.buf) then
    M.buf = vim.api.nvim_create_buf(false, true)
    vim.bo[M.buf].buftype = "nofile"
    vim.bo[M.buf].filetype = "xvimtutor"
    vim.api.nvim_buf_set_name(M.buf, "XVimTutor :: " .. lesson.title)
  end

  local lines = {}
  table.insert(lines, "╭──────────────────────────────────────────────────────────────────────────╮")
  table.insert(lines, string.format("│ %-72s │", lang.get("tutor_title")))
  table.insert(lines, string.format("│ %-72s │", string.format(lang.current == "ru" and "Урок %d из %d: %s" or "Lesson %d of %d: %s", idx, #lessons, lesson.title)))
  table.insert(lines, string.format("│ %-72s │", lesson.subtitle))
  table.insert(lines, "╰──────────────────────────────────────────────────────────────────────────╯")
  table.insert(lines, "")
  table.insert(lines, "  " .. lang.get("tutor_help"))
  table.insert(lines, "")

  for line in lesson.instructions:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end

  vim.bo[M.buf].modifiable = true
  vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, lines)
  
  -- Setup buffer local keymaps
  local opts = { buffer = M.buf, silent = true }
  vim.keymap.set("n", "<leader>tc", function() M.check_solution() end, vim.tbl_extend("force", opts, { desc = "Check solution" }))
  vim.keymap.set("n", "<leader>tn", function() M.next_lesson() end, vim.tbl_extend("force", opts, { desc = "Next lesson" }))
  vim.keymap.set("n", "<leader>tp", function() M.prev_lesson() end, vim.tbl_extend("force", opts, { desc = "Previous lesson" }))
  vim.keymap.set("n", "<leader>tr", function() M.render_lesson(M.current_idx) end, vim.tbl_extend("force", opts, { desc = "Reset lesson" }))
  vim.keymap.set("n", "<leader>tq", function() M.close() end, vim.tbl_extend("force", opts, { desc = "Close XVimTutor" }))
  vim.keymap.set("n", "<leader>tl", function() M.pick_lesson() end, vim.tbl_extend("force", opts, { desc = "Pick lesson" }))

  -- Switch window
  if not M.win or not vim.api.nvim_win_is_valid(M.win) then
    vim.cmd("enew")
    M.win = vim.api.nvim_get_current_win()
  end
  vim.api.nvim_win_set_buf(M.win, M.buf)

  vim.cmd("normal! G")
  notify(lesson.title)
end

function M.check_solution()
  local lessons = get_lessons()
  local lesson = lessons[M.current_idx]
  if not lesson then return end

  local lines = vim.api.nvim_buf_get_lines(M.buf, 0, -1, false)
  local full_text = table.concat(lines, "\n")

  local passed = false
  if lesson.target_match then
    if full_text:find(lesson.target_match, 1, true) then
      passed = true
    end
  elseif lesson.check_line then
    if full_text:find(lesson.check_line, 1, true) then
      passed = true
    end
  else
    passed = true
  end

  if passed then
    notify(string.format(lang.get("task_passed"), M.current_idx), vim.log.levels.INFO)
  else
    notify(lang.get("task_failed"), vim.log.levels.WARN)
  end
end

function M.next_lesson()
  local lessons = get_lessons()
  if M.current_idx < #lessons then
    M.render_lesson(M.current_idx + 1)
  else
    notify(lang.get("all_passed"), vim.log.levels.INFO)
  end
end

function M.prev_lesson()
  if M.current_idx > 1 then
    M.render_lesson(M.current_idx - 1)
  else
    notify(lang.get("first_lesson"), vim.log.levels.INFO)
  end
end

function M.close()
  if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
    vim.api.nvim_buf_delete(M.buf, { force = true })
    M.buf = nil
    M.win = nil
    notify(lang.get("tutor_closed"))
  end
end

function M.pick_lesson()
  local lessons = get_lessons()
  local items = {}
  for i, l in ipairs(lessons) do
    table.insert(items, string.format("%d. %s", i, l.title))
  end
  vim.ui.select(items, { prompt = lang.current == "ru" and "Выберите урок:" or "Select lesson:" }, function(choice, idx)
    if idx then
      M.render_lesson(idx)
    end
  end)
end

function M.setup()
  vim.api.nvim_create_user_command("XVimTutor", function(opts)
    local lesson_num = tonumber(opts.args) or 1
    M.render_lesson(lesson_num)
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("Tutor", function(opts)
    local lesson_num = tonumber(opts.args) or 1
    M.render_lesson(lesson_num)
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("XVimLang", function(opts)
    local l = opts.args:lower()
    if l == "ru" or l == "en" then
      lang.set_lang(l)
      if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
        M.render_lesson(M.current_idx)
      end
    else
      vim.notify("Usage: :XVimLang ru | en", vim.log.levels.WARN)
    end
  end, { nargs = 1 })

  vim.keymap.set("n", "<leader>tu", function() M.render_lesson(1) end, { desc = "Run XVimTutor" })
end

return M
