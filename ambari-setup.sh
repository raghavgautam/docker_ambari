set -x
set -e
wget -nv http://s3.amazonaws.com/dev.hortonworks.com/ambari/ubuntu16/2.x/latest/2.5.0.0/ambari.list -O /etc/apt/sources.list.d/ambari.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
apt-get update
# TODO delete following
apt-get install ambari-server -y
ambari-server setup -s
