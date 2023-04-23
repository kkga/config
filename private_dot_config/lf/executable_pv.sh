#!/bin/sh

case "$1" in
	# *.png*) term-image -S kitty -w "$2" "$1" ;;
	# *.webp*) term-image -S kitty -w "$2" "$1" ;;
	# *.gif*) term-image -S kitty -w "$2" "$1" ;;
	# *.jpg*) term-image -S kitty -w "$2" "$1" ;;
	# *.png*) chafa -f symbols -s "$2"x"$3" "$1" ;;
	# *.webp*) chafa -f symbols -s "$2"x"$3" "$1" ;;
	# *.gif*) chafa -f symbols -s "$2"x"$3" "$1" ;;
	# *.jpg*) chafa -f symbols -s "$2"x"$3" "$1" ;;
	# *.pdf) pdftotext "$1" - ;;
	*.tar*) tar tf "$1" ;;
	*.zip) unzip -l "$1" ;;
	*.rar) unrar l "$1" ;;
	*.7z) 7z l "$1" ;;
	# *.md) mdcat -P "$1" ;;
	*) bat --paging never --wrap character --color always "$1" ;;
esac
