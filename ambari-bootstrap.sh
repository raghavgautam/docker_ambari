source common-bootstrap.sh

for i in {1..10}; do
    echo "attemp $i to start ambari"
    ambari-server start
    ambari-server status && break
    sleep 10
done
ambari-server status
source end-bootstrap.sh
