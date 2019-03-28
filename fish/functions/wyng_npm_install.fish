function wyng_npm_install
    set_wyng_env

    echo "Running npm install locally"

    begin
        cd -l $OP_SRC/offerpop;
        . $NVM_DIR/nvm.sh;
        nvm use $OP_DJANGO_NODE_VERSION;
        npm install --loglevel warn
    end

    begin
        cd -l $OP_SRC/offerpop-services/v2/www;
        . $NVM_DIR/nvm.sh;
        nvm use 4.2.6;
        npm install --loglevel warn
    end

    begin
        cd -l $OP_SRC/experience-studio;
        . $NVM_DIR/nvm.sh;
        nvm use $OP_ES_NODE_VERSION;
        npm install --loglevel warn
    end
end
