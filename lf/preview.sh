#!/bin/sh
file="$1"
w="$2"
h="$3"
x="$4"
y="$5"

case "$(file -Lb --mime-type "$file")" in
    image/*)
        kitty +kitten icat --clear --transfer-mode=memory --stdin=no --place="${w}x${h}@${x}x${y}" "$file" < /dev/null > /dev/tty
        exit 1
        ;;
    *)
        # fall back to normal file preview for non-images (e.g. bat/cat)
        bat --color=always --style=plain "$file" 2>/dev/null || cat "$file"
        ;;
esac


