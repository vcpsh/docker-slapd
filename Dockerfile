# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
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
EXPOSE 636

VOLUME /var/lib/ldap
VOLUME /etc/ssl

RUN mkdir /etc/service/slapd
ADD slapd.sh /etc/service/slapd/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# vim:ts=8:noet:
