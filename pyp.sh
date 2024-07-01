#!/bin/bash

# Установка pygmentize
echo "Установка pygmentize..."
if ! command -v pygmentize &> /dev/null; then
    apt-get update
    apt-get install pip
    pip3 install pygments 
else
    echo "pygmentize уже установлен."
fi

# Добавление функций в ~/.bashrc
BASHRC_FILE="$HOME/.bashrc"
FUNCTIONS_TO_ADD=$(cat << 'EOF'

# Функция для вывода файлов с подсветкой синтаксиса с помощью pygmentize
function catpyg() {
    for file in "$@"; do
        if [ -f "$file" ]; then
            pygmentize -g "$file" | cat
        else
            echo "Файл не найден: $file"
        fi
    done
}

# Функция для просмотра файлов с подсветкой синтаксиса в less с помощью pygmentize
function lesspyg() {
    for file in "$@"; do
        if [ -f "$file" ]; then
            pygmentize -g "$file" | less -R
        else
            echo "Файл не найден: $file"
        fi
    done
}
EOF
)

if ! grep -q "function catpyg" "$BASHRC_FILE"; then
    echo "Добавление функций catpyg и lesspyg в $BASHRC_FILE..."
    echo "$FUNCTIONS_TO_ADD" >> "$BASHRC_FILE"
    echo "Функции успешно добавлены в $BASHRC_FILE."
else
    echo "Функции catpyg и lesspyg уже существуют в $BASHRC_FILE."
fi

echo "Скрипт выполнен. Чтобы изменения вступили в силу, выполните: source ~/.bashrc"