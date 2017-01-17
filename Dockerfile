from raghavgautam/ubuntu

add . /scripts
workdir /scripts
run chmod 755 *.sh
run ./ambari-setup.sh

ADD ssh /root/.ssh
RUN chmod 600 /root/.ssh/id_rsa

EXPOSE 22
EXPOSE 8080
CMD [./ambari-install.sh]
