source common-bootstrap.sh

for i in {1..12}; do
    echo "attemp $i to start ambari"
    ambari-server start
    sleep 30
    ambari-server status && break
done
ambari-server status
tail -f --retry --follow=name $(find /var/log -iname 'ambari-server.log')
