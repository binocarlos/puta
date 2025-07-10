alias k='kubectl'
alias gs='git status'
alias gd='git diff'
alias ga='git add -A && git commit'
alias gp='git push origin master'
alias gas='git add -A && git commit -s -S'
alias gcs='git commit -s -S'
alias gc='git checkout'
alias gpl='git pull origin'
alias gps='git push origin'
alias gl='git log --all --graph --oneline --decorate'
alias drm='docker rm -f $(docker ps -aq)'
alias dps='docker ps -a'
alias sudo='sudo -E env "PATH=$PATH"'
alias opus='claude --model claude-opus-4-20250514'

# git
export GIT_EDITOR=vim
# go
export GOPATH=/home/kai/go
export GOBIN=/home/kai/go/bin
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/bin:$HOME/.yarn/bin
export CLOUDSDK_PYTHON=python3
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
