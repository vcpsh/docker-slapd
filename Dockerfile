FROM phusion/baseimage:0.9.19
MAINTAINER AK Internet <internet@vcp-sh.de>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Include latest updates and patches
RUN apt-get update && apt-get upgrade -y

# Install slapd
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y slapd


# Default configuration: can be overridden at the docker command line
ENV LDAP_ROOTPASS superSecretRootPassword
ENV LDAP_ORGANISATION VCP Schleswig-Holstein
ENV LDAP_DOMAIN vcp-sh.de

EXPOSE 389

VOLUME /var/lib/ldap

RUN mkdir -p /etc/my_init.d
ADD slapd.sh /etc/my_init.d/slapd.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# vim:ts=8:noet:
