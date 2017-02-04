## slapd

A basic configuration of the OpenLDAP server, slapd, with support for data
volumes.

This image will **not** initialize a configuration of slapd. You need to bind your own ldap config to the /etc/ldap volume.

For example, to start a container running slapd for the `mycorp.com` domain,
with data stored in `/data/ldap` on the host, use the following:

    docker run -v /DATADIR:/var/lib/ldap \
    -v /CONFIGDIR:/etc/ldap \
    vcpsh/slapd:latest

You can find out which port the LDAP server is bound to on the host by running
`docker ps` (or `docker port <container_id> 389`). You could then load an LDIF
file (to set up your directory) like so:

**NB**: Please be aware that by default docker will make the LDAP port
accessible from anywhere if the host firewall is unconfigured.
