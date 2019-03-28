function wyng_clean
    wyng_machine

    touch $OP_SRC/docker/compose/django/.env

    $OP_SRC/docker/remove.sh
    $OP_SRC/docker/setup/clean.sh
    $OP_SRC/docker/pull.sh

    wyng_pull

    rm -rf $OP_SRC/offerpop/node_modules/ \
    $OP_SRC/offerpop-services/node_modules/ \
    $OP_SRC/experience-studio/node_modules/

    $OP_SRC/docker/setup/import.sh
    $OP_SRC/docker/setup/migrate.sh

    wyng_npm_install
end
