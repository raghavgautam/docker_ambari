source common-bootstrap.sh
ambari-agent start || echo "ambari agent not found - looks like a fresh installation"
source end-bootstrap.sh
