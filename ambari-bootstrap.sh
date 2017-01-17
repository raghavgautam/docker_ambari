source common-bootstrap.sh

for i in {1..10}; do
    echo "attemp $i to start ambari"
    ambari-server start
    sleep 10
    ambari-server status && break
done
ambari-server status
source end-bootstrap.sh
