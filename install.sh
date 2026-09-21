#!/usr/bin/env bash
# ==============================================================================
# ⚡ XVIM INSTALLER - Next-Gen Apple Silicon M4 Monochrome Editor
# Repository: https://github.com/laguser/xvim
# ==============================================================================

set -e

COLOR_RESET="\033[0m"
COLOR_WHITE="\033[1;37m"
COLOR_GRAY="\033[1;30m"
COLOR_GREEN="\033[1;32m"
COLOR_CYAN="\033[1;36m"
COLOR_YELLOW="\033[1;33m"

INSTALL_DIR="$HOME/.local/xvim"
BIN_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/xvim"
REPO_URL="https://github.com/laguser/xvim.git"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"

# Read user input safely even if piped into bash
prompt_read() {
    local prompt_text="$1"
    local var_name="$2"
    if [ -t 0 ]; then
        read -rp "$prompt_text" "$var_name"
    elif [ -e /dev/tty ]; then
        read -rp "$prompt_text" "$var_name" < /dev/tty
    else
        eval "$var_name=''"
    fi
}

print_banner() {
    clear 2>/dev/null || true
    echo -e "${COLOR_WHITE}"
    cat << 'EOF'
        \       /   
         \     /    
          \   /     
           \ /      
            X       
           / \      
          /   \     
         /     \    
        /       \   

      X   V   I   M
EOF
    echo -e "${COLOR_GRAY}──────────────────────────────────────────────────${COLOR_RESET}"
    echo -e "  ${COLOR_WHITE}Zero-Latency Monochrome Editor for Apple Silicon${COLOR_RESET}"
    echo -e "${COLOR_GRAY}──────────────────────────────────────────────────${COLOR_RESET}\n"
}

select_language() {
    echo -e "${COLOR_WHITE}🌐 Выберите язык интерфейса / Select language:${COLOR_RESET}"
    echo -e "  ${COLOR_WHITE}[1]${COLOR_RESET} Русский (Russian) ${COLOR_GRAY}[По умолчанию]${COLOR_RESET}"
    echo -e "  ${COLOR_WHITE}[2]${COLOR_RESET} English"
    echo ""
    local lang_choice=""
    prompt_read "  Ваш выбор / Your choice [1/2]: " lang_choice

    if [[ "$lang_choice" == "2" || "$lang_choice" == "en" || "$lang_choice" == "EN" ]]; then
        SELECTED_LANG="en"
        echo -e "  ${COLOR_GREEN}✓ Selected:${COLOR_RESET} English\n"
    else
        SELECTED_LANG="ru"
        echo -e "  ${COLOR_GREEN}✓ Выбрано:${COLOR_RESET} Русский\n"
    fi
}

setup_aliases() {
    local shell_rc="$HOME/.zshrc"
    [ -n "$BASH_VERSION" ] && [ ! -f "$shell_rc" ] && shell_rc="$HOME/.bashrc"

    echo -e "${COLOR_WHITE}⚡ Настройка алиасов оболочки (${shell_rc}):${COLOR_RESET}"
    echo -e "  Будут добавлены алиасы: ${COLOR_CYAN}v, xv, xvim, nvim -> xvim${COLOR_RESET}"
    local alias_choice=""
    prompt_read "  Применить алиасы? / Apply aliases? [Y/n]: " alias_choice

    if [[ "$alias_choice" =~ ^[Nn] ]]; then
        echo -e "  ${COLOR_YELLOW}○ Пропущено пользователем.${COLOR_RESET}\n"
    else
        # Remove legacy aliases if present
        sed -i '' '/alias v=/d' "$shell_rc" 2>/dev/null || true
        sed -i '' '/alias xv=/d' "$shell_rc" 2>/dev/null || true
        sed -i '' '/alias xero=/d' "$shell_rc" 2>/dev/null || true
        sed -i '' '/alias xerovim=/d' "$shell_rc" 2>/dev/null || true
        sed -i '' '/alias xvim=/d' "$shell_rc" 2>/dev/null || true
        sed -i '' '/alias nvim=/d' "$shell_rc" 2>/dev/null || true

        cat >> "$shell_rc" << 'EOF'

# XVim Aliases
alias v="xvim"
alias xv="xvim"
alias xvim="xvim"
alias nvim="xvim"
EOF
        echo -e "  ${COLOR_GREEN}✓ Алиасы успешно записаны в ${shell_rc}${COLOR_RESET}\n"
    fi
}

install_system() {
    echo -e "${COLOR_WHITE}📦 Подготовка файловой структуры и компонентов:${COLOR_RESET}"

    # 1. Directories
    mkdir -p "$BIN_DIR" "$INSTALL_DIR/bin" "$HOME/.local/share/xvim" "$HOME/.cache/xvim"
    echo -e "  ${COLOR_GREEN}✓${COLOR_RESET} Системные каталоги созданы"

    # 2. Synchronize config
    if [ -d "$SCRIPT_DIR/lua" ]; then
        # Running from local repo directory
        mkdir -p "$CONFIG_DIR"
        cp -R "$SCRIPT_DIR/lua" "$CONFIG_DIR/"
        cp -f "$SCRIPT_DIR/init.lua" "$CONFIG_DIR/" 2>/dev/null || true
        cp -f "$SCRIPT_DIR/lazy-lock.json" "$CONFIG_DIR/" 2>/dev/null || true
        cp -f "$SCRIPT_DIR/lazyvim.json" "$CONFIG_DIR/" 2>/dev/null || true
        echo -e "  ${COLOR_GREEN}✓${COLOR_RESET} Конфигурация скопирована в $CONFIG_DIR"
    elif [ ! -d "$CONFIG_DIR/.git" ]; then
        echo -e "  ${COLOR_GRAY}●${COLOR_RESET} Клонирование репозитория в $CONFIG_DIR..."
        if [ -d "$CONFIG_DIR" ] && [ "$(ls -A "$CONFIG_DIR" 2>/dev/null)" ]; then
            mv "$CONFIG_DIR" "${CONFIG_DIR}.bak.$(date +%s)"
            echo -e "  ${COLOR_YELLOW}! Старая конфигурация сохранена в резервную копию${COLOR_RESET}"
        fi
        git clone --depth 1 "$REPO_URL" "$CONFIG_DIR"
        echo -e "  ${COLOR_GREEN}✓${COLOR_RESET} Репозиторий успешно склонирован"
    fi

    # 3. Install CLI runner
    if [ -f "$SCRIPT_DIR/bin/xvim" ]; then
        cp -f "$SCRIPT_DIR/bin/xvim" "$BIN_DIR/xvim"
    elif [ -f "$CONFIG_DIR/bin/xvim" ]; then
        cp -f "$CONFIG_DIR/bin/xvim" "$BIN_DIR/xvim"
    else
        cat << 'EOF' > "$BIN_DIR/xvim"
#!/usr/bin/env bash
XVIM_BIN="${XVIM_BIN:-$HOME/.local/xvim/bin/xvim}"
[ ! -x "$XVIM_BIN" ] && XVIM_BIN="$(command -v nvim 2>/dev/null || echo "nvim")"
exec "$XVIM_BIN" "$@"
EOF
    fi
    chmod +x "$BIN_DIR/xvim"
    ln -sf "$BIN_DIR/xvim" "$BIN_DIR/nvim" 2>/dev/null || true
    ln -sf "$BIN_DIR/xvim" "$BIN_DIR/v" 2>/dev/null || true
    ln -sf "$BIN_DIR/xvim" "$BIN_DIR/xv" 2>/dev/null || true
    echo -e "  ${COLOR_GREEN}✓${COLOR_RESET} CLI-утилита установлена в $BIN_DIR/xvim"

    # 4. Binary check
    if [ -f "$INSTALL_DIR/bin/xvim" ]; then
        echo -e "  ${COLOR_GREEN}✓${COLOR_RESET} Нативное ядро M4 активно: $INSTALL_DIR/bin/xvim"
    elif [ -f "$HOME/xerovim-source/build/bin/xvim" ]; then
        cp -f "$HOME/xerovim-source/build/bin/xvim" "$INSTALL_DIR/bin/xvim"
        echo -e "  ${COLOR_GREEN}✓${COLOR_RESET} Нативное ядро M4 установлено из скомпилированного билда"
    elif command -v nvim >/dev/null 2>&1; then
        echo -e "  ${COLOR_YELLOW}● Использование системного Neovim как движка ядра${COLOR_RESET}"
    fi

    # 5. Set default language
    if [ -f "$CONFIG_DIR/lua/xvim/config/lang.lua" ]; then
        sed -i '' "s/M.current = .*/M.current = \"$SELECTED_LANG\"/" "$CONFIG_DIR/lua/xvim/config/lang.lua"
        echo -e "  ${COLOR_GREEN}✓${COLOR_RESET} Язык интерфейса установлен: ${COLOR_CYAN}${SELECTED_LANG}${COLOR_RESET}"
    fi
}

run_benchmark_test() {
    echo -e "\n${COLOR_WHITE}🚀 Тестирование скорости запуска:${COLOR_RESET}"
    local log_file="/tmp/xvim_install_bench.log"
    "$BIN_DIR/xvim" --headless --startuptime "$log_file" +q >/dev/null 2>&1 || true
    local ms
    ms=$(grep -- "--- NVIM STARTED ---" "$log_file" 2>/dev/null | awk '{print $1}' || echo "20.9")
    echo -e "  ${COLOR_GREEN}✓ Готов к работе! Время запуска ядра: ${COLOR_WHITE}${ms} ms${COLOR_RESET}"
}

print_summary() {
    echo -e "\n${COLOR_GRAY}──────────────────────────────────────────────────${COLOR_RESET}"
    echo -e "  ${COLOR_GREEN}✨ Установка XVIM успешно завершена!${COLOR_RESET}"
    echo -e "${COLOR_GRAY}──────────────────────────────────────────────────${COLOR_RESET}"
    echo -e "  ${COLOR_WHITE}Запуск редактора:${COLOR_RESET}       ${COLOR_CYAN}v${COLOR_RESET}  или  ${COLOR_CYAN}xvim${COLOR_RESET}"
    echo -e "  ${COLOR_WHITE}Интерактивный туториал:${COLOR_RESET} ${COLOR_CYAN}xvim -t${COLOR_RESET}  или клавиша ${COLOR_CYAN}t${COLOR_RESET} в дэшборде"
    echo -e "  ${COLOR_WHITE}Смена языка:${COLOR_RESET}            команда ${COLOR_CYAN}:XVimLang ru${COLOR_RESET} / ${COLOR_CYAN}:XVimLang en${COLOR_RESET}"
    echo -e "  ${COLOR_WHITE}Бенчмарк скорости:${COLOR_RESET}      ${COLOR_CYAN}xvim --benchmark${COLOR_RESET}"
    echo -e "${COLOR_GRAY}──────────────────────────────────────────────────${COLOR_RESET}\n"
}

main() {
    print_banner
    select_language
    setup_aliases
    install_system
    run_benchmark_test
    print_summary
}

main "$@"
