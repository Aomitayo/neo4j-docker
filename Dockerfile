# Create a neo4j server container

FROM ubuntu

MAINTAINER Adedayo Omitayo "adedayo.omitayo@flowswift.com"

# Add diversions
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

# Import neo4j signing key
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
#RUN bash -c "echo deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen > /etc/apt/sources.list.d/10gen.list"

RUN wget -O - http://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add - 

# Create an Apt sources.list file
RUN echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list

# Find out about the files in neo4j repository
RUN apt-get update

# Install Neo4j, community edition
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get -y install neo4j

EXPOSE 7474

#stop the default neo4j service
RUN service neo4j-service stop

# start neo4j server, available at http://localhost:7474 of the target machine
CMD /var/lib/neo4j/bin/neo4j start