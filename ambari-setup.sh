set -x
set -e
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install openssh-server -y
service ssh start
mkdir ~/.ssh/
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
apt-get install wget -y
wget -nv http://s3.amazonaws.com/dev.hortonworks.com/ambari/ubuntu16/2.x/latest/2.5.0.0/ambari.list -O /etc/apt/sources.list.d/ambari.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
apt-get update
# TODO delete following
apt-get install ambari-server -y
ambari-server setup -s
