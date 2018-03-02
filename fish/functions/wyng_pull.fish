function wyng_pull
    set_wyng_env

    set -l repo_list auth-service event-api-service experience-service experience-studio media-service offerpop offerpop-services reporting-service submission-service integration-service voting-service code-service web-service export-service publish-service profile-service

    for repo in $repo_list
        if test -e $OP_SRC/$repo
            echo "Pulling $repo" (git -C $OP_SRC/$repo symbolic-ref --short HEAD) "..."
            git -C $OP_SRC/$repo pull
        else
            git clone git@github.com:offerpop/$repo.git $OP_SRC/$repo
        end
    end
end
