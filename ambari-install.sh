set -x
set -e
service ssh start
#TODO uncomment following
#export DEBIAN_FRONTEND=noninteractive
#apt-get update
#apt-get install ambari-server -y
#ambari-server setup -s
ambari-server start
