function workspace
    # 인자가 없으면 사용법 출력
    if test (count $argv) -eq 0
        echo "Usage: live <session_name>"
        return 1
    end

    # 첫 번째 인자를 변수에 저장 (예: liveview, livecore)
    set SESSION_ARG $argv[1]

    switch $SESSION_ARG
        case live
            # live 세션 생성
            tmux new-session -d -s live

            # 위쪽 창에 liveview 생성 및 Neovim 실행
            tmux rename-window -t live:0 liveview
            tmux send-keys -t live:liveview tliveview C-m
            tmux send-keys -t live:liveview nvim C-m

            # dev 창 생성 및 실행 (-l 8 : 8줄 높이)
            tmux split-window -v -l 6 -t live:liveview
            tmux send-keys -t live:liveview tliveview C-m
            tmux send-keys -t live:liveview "npm run dev" C-m

            # 아래쪽 패널의 높이를 8줄로 조정
            tmux resize-pane -D 6

            # 두번째 윈도우 추가
            tmux new-window -t live:1 -n livecore
            tmux send-keys -t live:livecore tlivecore C-m
            tmux send-keys -t live:livecore nvim C-m

            tmux split-window -v -l 6 -t live:livecore
            tmux send-keys -t live:livecore tlivecore C-m
            tmux send-keys -t live:livecore "npm run dev" C-m


            # 첫 번째 창에 포커스 유지
            tmux select-pane -t 0

            # tmux 세션 연결
            tmux attach -t live
        case tv
            # TV 세션 생성    
            tmux new-session -d -s tv

            # 위쪽 창에 tv docker 접속
            tmux rename-window -t tv docker
            tmux send-keys -t tv:docker tsmartTV C-m
            tmux send-keys -t tv:docker "echo \"ssh root@203.238.136.43 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null\"" C-m
            tmux send-keys -t tv:docker "ssh ckdtjs505@203.238.135.100" C-m

            tmux attach -t tv
        case "*"
            echo "사용할수 있는명령어 : tv, live"
    end
end
