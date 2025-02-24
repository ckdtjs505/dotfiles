#!/bin/bash

# 인자가 없으면 사용법 출력
if [ -z "$1" ]; then
  echo "Usage: $0 <session_name>"
  exit 1
fi

# 첫 번째 인자를 변수에 저장 ( 예 : liveview, livecore)
SESSION_ARG=$1

# workspace 생성
tmux new-session -d -s workspace

# 위쪽 창에 liveview 생성 및 Neovim 실행
tmux rename-window -t workspace main
tmux send-keys -t workspace "t${SESSION_ARG}" C-m
tmux send-keys -t workspace "nvim" C-m

# dev 생성 및 실행 ( -l 6 : 6줄 높이)
tmux split-window -v -l 8 -t workspace
tmux send-keys -t workspace "t${SESSION_ARG}" C-m
tmux send-keys -t workspace "npm run dev" C-m

# 아래쪽 패널의 높이를 10줄로 생성:
tmux resize-pane -D 8

# 첫번째 창에 포커스 유지
tmux select-pane -t 0

# tmux 세션 연결
tmux attach -t workspace
