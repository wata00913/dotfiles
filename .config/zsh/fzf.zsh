HIS_PATH="$HOME/.cache/shell/chpwd-recent-dirs"

fd() {
    local select_dir=$(find . -path '*/.*' -prune -o -type d -print 2> /dev/null | fzf)
    cd $select_dir
}

hd() {
    local select_his_dir=$(cat $HIS_PATH | sed -e "s/[$\']//g" | fzf)
    cd $select_his_dir
}
