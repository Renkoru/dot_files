function wyng_ls_repos
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
        set -l branch (cd $OP_SRC/$repo && git rev-parse --abbrev-ref HEAD)

        if test $branch != "develop"
            set_color red
        end

        echo "$repo : $branch"

        set_color normal
    end
end
