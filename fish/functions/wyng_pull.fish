function wyng_pull
    set_wyng_env

    set -l repo_list auth-service \
    code-service \
    docker \
    event-api-service \
    experience-service \
    experience-studio \
    export-service \
    instagram-ingestion \
    integration-service \
    living-style-guide \
    media-service \
    offerpop \
    offerpop-services \
    profile-service \
    publish-service \
    quiz-service \
    reporting-service \
    submission-service \
    voting-service \
    web-service

    for repo in $repo_list
        if test -e $OP_SRC/$repo
            echo "Pulling $repo" (git -C $OP_SRC/$repo symbolic-ref --short HEAD) "..."
            git -C $OP_SRC/$repo pull
        else
            git clone git@github.com:offerpop/$repo.git $OP_SRC/$repo
        end
    end
end
