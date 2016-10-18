from ubuntu:14.04

add . /scripts
workdir /scripts
run chmod 755 *.sh
run ./ambari-setup.sh
EXPOSE 22
EXPOSE 8080
CMD [./ambari-install.sh]
