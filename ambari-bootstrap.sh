source common-bootstrap.sh

for i in {1..10}; do
    ambari-server status && break
    ambari-server start
    echo "try $i failed"
    sleep 10
done
source end-bootstrap.sh
