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

