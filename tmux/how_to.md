
# copy / paste

dnf install xclip xsel

## OSC 52 bases solution

printf $'\e]52;c;%s\a' "$(echo foobarx | base64)"

printf '\e]52;c;%s\a' "$(echo text OSC | base64)"

# Linux version of OSX pbcopy and pbpaste.
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

echo "hello pb" | pbcopy
pbpaste

## kitty

ctrl-shift-v = to paste from clipboars