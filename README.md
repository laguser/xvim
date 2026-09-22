# xvim

```
    \       /
     \     / 
      \   /  
       \ /   
        X    
       / \   
      /   \  
     /     \ 
    /       \

  x   v   i   m
```

минималистичный монохромный редактор на базе neovim для linux и macos.
прозрачный фон под терминал, запуск ~20мс, встроенный интерактивный тьютор и поддержка конфигов `.xvim`.

## установка

```bash
curl -fsSL https://raw.githubusercontent.com/laguser/xvim/main/install.sh | bash
```

вручную:

```bash
git clone --depth 1 https://github.com/laguser/xvim.git ~/.config/xvim
~/.config/xvim/install.sh
```

скрипт предлагает выбор языка (`ru` / `en`) и прописывает алиасы `v`, `xv`, `xvim`, `nvim`.

## тьютор

встроенный интерактивный тренажёр с проверкой выполнения в реальном времени:

```bash
xvim -t
```

или внутри редактора: `:XVimTutor` (хоткей `<leader>tu`).  
переключение языка: `:XVimLang ru` или `:XVimLang en`.

## конфиги проектов

автоматически подхватывает локальные настройки в корне проекта:
- `.xvim`
- `.xvim.lua`
- `.xvimrc`

## управление

лидер: `<Space>` (пробел)

```
<Space><Space>   поиск файлов
<Space>/         поиск по тексту (grep)
<Space>e         проводник
<Space>w         сохранить файл
<Space>q         закрыть окно
s                flash-прыжок к слову
[b / ]b          предыдущий / следующий буфер
<Space>bd        закрыть буфер
<Space>|         вертикальный сплит
<Space>-         горизонтальный сплит
<Space>xx        панель ошибок (trouble)
<Space>tu        запуск тьютора
```

## cli

```bash
xvim             запуск
xvim file.c      открыть файл
xvim -t          запуск тьютора
xvim --bench     тест скорости запуска (5 прогонов)
xvim --clean     очистить кэш
xvim -v          версия
```

## зависимости

- neovim >= 0.10 (или скомпилированное ядро xvim)
- git, curl
- nerd font (для символов интерфейса)
- linux: `wl-clipboard` (wayland) или `xclip` (x11) для системного буфера обмена

## лицензия

MIT
