function set_wyng_env
    set -x -g OP_SRC $HOME/projects/wyng
    set -x -g OP_DOCKER_DESKTOP true
    set -x -g COMPOSE_FILE docker-compose.yml:docker-compose.dev.yml
    set -x -g OP_EXPORTS $OP_SRC/docker/exports
    set -x -g OP_DOCKER_MACHINE "op-dev"
    set -x -g OP_DOCKER_REGISTRY "034112772293.dkr.ecr.us-east-1.amazonaws.com/"
    set -x -g OP_TAG ":develop"
    set -x -g OP_ENV "dev"
    set -x -g OP_DJANGO_NODE_VERSION 8.1.2
    set -x -g OP_ES_NODE_VERSION 14.4.0
    set -x -g OP_DOCKER_FOR_MAC false
end

# If a local_overrides.sh file exists load it
# FILE=$OP_SRC/docker/local_overrides.sh && test -f $FILE && source $FILE

# wyng-machine
