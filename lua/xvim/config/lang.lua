-- ==============================================================================
-- ⚡ XVIM - Internationalization (RU / EN)
-- ==============================================================================

local M = {}

-- Default language: "ru" or "en"
M.current = "ru"

M.i18n = {
  ru = {
    files = "файлы",
    grep = "поиск",
    recent = "недавние",
    tutor = "туториал",
    config = "конфиг",
    quit = "выход",
    recent_title = "Недавние",
    projects_title = "Проекты",
    tutor_title = "⚡ XVIMTUTOR :: ИНТЕРАКТИВНЫЙ ТУТОРИАЛ VIM & XVIM",
    tutor_help = "[ХОТКЕИ: <leader>tc = Проверить | <leader>tn = След. | <leader>tp = Пред. | <leader>tr = Сброс | <leader>tq = Выход]",
    task_passed = "🎉 Отлично! Урок %d успешно пройден!\nНажми <leader>tn для следующего урока.",
    task_failed = "❌ Задание пока не выполнено в точности.\nСверься с инструкцией или нажми <leader>tr для сброса.",
    all_passed = "🏆 Все уроки XVimTutor пройдены! Ты готов к быстрой работе в Vim!",
    first_lesson = "Это первый урок",
    tutor_closed = "XVimTutor закрыт",
  },
  en = {
    files = "files",
    grep = "grep",
    recent = "recent",
    tutor = "tutor",
    config = "config",
    quit = "quit",
    recent_title = "Recent",
    projects_title = "Projects",
    tutor_title = "⚡ XVIMTUTOR :: INTERACTIVE VIM & XVIM MASTERY CURRICULUM",
    tutor_help = "[HOTKEYS: <leader>tc = Check | <leader>tn = Next | <leader>tp = Prev | <leader>tr = Reset | <leader>tq = Quit]",
    task_passed = "🎉 Well done! Lesson %d passed successfully!\nPress <leader>tn for the next lesson.",
    task_failed = "❌ Exercise not completed yet.\nReview the instructions or press <leader>tr to reset.",
    all_passed = "🏆 All XVimTutor lessons completed! You are ready for high-speed Vim editing!",
    first_lesson = "This is the first lesson",
    tutor_closed = "XVimTutor closed",
  },
}

function M.get(key)
  local lang = M.current or "ru"
  local dict = M.i18n[lang] or M.i18n.ru
  return dict[key] or key
end

function M.set_lang(lang)
  if lang == "ru" or lang == "en" then
    M.current = lang
    vim.g.xvim_lang = lang
    local config_file = vim.fn.stdpath("config") .. "/lua/xvim/config/lang.lua"
    if vim.fn.filereadable(config_file) == 1 then
      local lines = vim.fn.readfile(config_file)
      for i, line in ipairs(lines) do
        if line:match("^M%.current%s*=") then
          lines[i] = string.format('M.current = "%s"', lang)
          break
        end
      end
      vim.fn.writefile(lines, config_file)
    end
    vim.notify("[XVIM] Language set to: " .. lang:upper(), vim.log.levels.INFO)
  else
    vim.notify("Usage: :XVimLang ru | en", vim.log.levels.WARN)
  end
end

return M
