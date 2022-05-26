# \e[1;{$color}m is the escape string to set the color \e[0m resets the color back
reset='\e[0m'
black=30
red='\e[1;41m'
green='\e[1;32m'
yellowBg='\e[1;43m'
blue='\e[1;34m'
magenta=35
cyan='\e[1;36m'
white='\e[7;37m'
whiteBg='\e[1;47m'

function error() {
    #-e enable interpretation of backslash escapes
    echo -e "$red$*$reset"
}
function info() {
    #-e enable interpretation of backslash escapes
    echo -e "$blue$*$reset\n"
}
function highlight() {
    #-e enable interpretation of backslash escapes
    echo -e "$white$*$reset"
}
function success() {
    #-e enable interpretation of backslash escapes
    echo -e "$green$*$reset"
}
function warning() {
    #-e enable interpretation of backslash escapes
    echo -e "$yellowBg$*$reset"
}
#hline makes a a string that is at least 60 chars long
# then tr changes every space into -
function hline() {
    printf "$cyan%30s $1 %30s $reset\n" | tr ' ' -
}