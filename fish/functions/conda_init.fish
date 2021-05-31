function conda_init
    set -x PATH "/opt/anaconda/bin" $PATH
    eval /opt/anaconda/bin/conda "shell.fish" "hook" $argv | source
end
