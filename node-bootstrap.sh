source common-bootstrap.sh
ambari-agent start || echo "ambari agent not found - looks like a fresh installation"
tail -f --retry --follow=name /var/log/ambari-agent/ambari-agent.log
