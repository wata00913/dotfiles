fd() {
    local select_dir=$(find . -path '*/.*' -prune -o -type d -print 2> /dev/null | fzf)
    cd $select_dir
}

hd() {
}
