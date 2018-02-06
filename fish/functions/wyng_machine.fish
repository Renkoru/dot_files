function wyng_machine
    set_wyng_env

    if test -z $OP_DOCKER_MACHINE
        echo "You must set the OP_DOCKER_MACHINE environment variable."
    else
        set machine_exists (docker-machine ls -q | grep $OP_DOCKER_MACHINE)
        if test -z $machine_exists
            docker-machine create --driver virtualbox --virtualbox-host-dns-resolver --virtualbox-memory 4096 $OP_DOCKER_MACHINE
        end

        set docker_status (docker-machine status $OP_DOCKER_MACHINE)

        if test $docker_status != "Running"
            docker-machine start $OP_DOCKER_MACHINE
        end

        eval (docker-machine env $OP_DOCKER_MACHINE)

        set docker_machine_ip (docker-machine ip (docker-machine active))
        set hosts_ip (grep -E "^\s*[1-9].*\swyng\.com\b" /etc/hosts | awk '{print $1}')

        if test -z hosts_ip
            set commented (grep -E "^\s*#\s*[1-9].*\swyng\.com\b" /etc/hosts)
            echo "You may wish to uncomment this line: $commented"
        else
            if test $docker_machine_ip = $hosts_ip
                echo "hosts file and docker-machine are configured for $docker_machine_ip"
            else
                echo "*** Docker machine is running on $docker_machine_ip, but hosts file is set for $hosts_ip ***"
            end
        end
    end
end
