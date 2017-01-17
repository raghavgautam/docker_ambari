# -*- bash: cluster-ops\.sh; -*-

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $1 == "build" ]]; then
    export DOCKER_OPT="--no-cache"
    docker run --rm raghavgautam/ubuntu "true" || docker build ${DOCKER_OPT} -t raghavgautam/ubuntu --file UbuntuDockerfile .
    docker build ${DOCKER_OPT} -t docker_ambari --file Dockerfile .
elif [[ $1 == "start" ]]; then
    bash "${BASH_SOURCE[0]}" stop
    domain=".hw.com"
    docker network create anw
    docker run -p 8080:8080 --network anw --name ambari$domain --volume "${DIR}":/host_pwd --volume "${HOME}":/host_home -d docker_ambari bash -c "cd /host_pwd; source ambari-bootstrap.sh"
    node_names=()
    for i in 0{1..3}; do
        node_name=node$i$domain
        node_names+=($node_name)
        docker run --name $node_name -h $node_name --network anw --volume "${DIR}":/host_pwd --volume "${HOME}":/host_home -d raghavgautam/ubuntu bash -c 'cd /host_pwd/; source node-bootstrap.sh'
    done
    sleep 3
    bash "${BASH_SOURCE[0]}" status
    echo copying node names & ssh private key to clipboard
    {echo ${node_names[@]} | tr ' ' '\n'; echo; cat ssh/id_rsa} | pbcopy
    echo "Done."
elif [[ $1 == "stop" ]]; then
    docker kill $(docker ps -f=network=anw -q) 2>/dev/null || echo "No running containers found."
    docker rm $(docker ps -a -f=network=anw -q) 2>/dev/null || echo "No stopped containers found."
    docker network rm anw
    docker ps -a
elif [[ $1 == "status" ]]; then
    docker ps -a -f=network=anw
else
    echo "Missing arg, expected: build, start, status, stop"
fi
echo Done.
