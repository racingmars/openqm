OpenQM GPL 2.6-6, with improvements
===================================

OpenQM is a multi-value "PICK System"-type database and application
development platform. OpenQM is currently a [commercial product from Rocket
Software][1], but the original authors, Ladybridge Systems, once released a
GPL-licensed version of the Linux version of OpenQM. The last version released
under the GPL was 2.6-6. This image contains that last GPL release, with some
minor enhancements. The source code for OpenQM and this Docker container are
[available on GitHub][2].

[1]: https://www.rocketsoftware.com/products/rocket-multivalue-application-development-platform/rocket-open-qm
[2]: https://github.com/racingmars/openqm/

Using this image
----------------

For persistent data, create a directory or volume to use for the `/qmdata`
directory inside the container.

This image exposes port 22 for SSH login, 4242 for telnet login, and 4243 for
the qmclient interface.

A user named "qmuser" will be created. The password will be randomly generated
when you run the container and printed in the container log (e.g. run `docker
log` after starting the container to see the generated password if the
container is run in the background), or you may pass the `QMUSER_PASSWORD`
environment variable in to the container to set a password.

For example, to run the container with port 4222 as the SSH port, ports 4242
and 4243 as the qmserver and qmclient ports, and provide persistent data
storage, you can start the container with:

```plaintext
$ mkdir qmdata
$ docker run --name openqm -d \
   -p 4222:22 -p 4242:4242 -p 4243:4243 \
   -v $(pwd)/qmdata:/qmdata \
   racingmars/openqm:latest
```

If you examine the container logs, you will see the randomly-generated
password for the qmuser user:

```plaintext
$ docker logs openqm
[...]

*** Generating password for qmuser ***
*** Password is: F6EqFdAhwvPjNMAq ***

[...]
```

You may then telnet to port 4242 to log in:

```plaintext
$ telnet localhost 4242

[ OpenQM Rev 2.6-6   Copyright Ladybridge Systems, 2007 ]

This program is free software and is supplied with ABSOLUTELY NO WARRANTY.
You are welcome to modify or redistribute this software subject to certain
conditions.  For details type CONFIG GPL.

Telnet connection from 172.17.0.1
Username: qmuser
Password: ****************

:
```

Or you may use SSH to log in:

```plaintext
$ ssh -p 4222 qmuser@localhost
[...]
qmuser@localhost's password: 

[ OpenQM Rev 2.6-6   Copyright Ladybridge Systems, 2007 ]

This program is free software and is supplied with ABSOLUTELY NO WARRANTY.
You are welcome to modify or redistribute this software subject to certain
conditions.  For details type CONFIG GPL.

:
```

If you're new to all this, know that `OFF` or `QUIT` will log you off.

In both cases, you are in the default account, named QMUSER, for the
user qmuser.

The QMUSER account is located on disk at `/qmdata/qmuser`, and the QMSYS
account is at `/qmdata/qmsys`. If you create additional accounts, create them
under `/qmdata` so they are in the persistent data storage volume (e.g.
`CREATE.ACCOUNT NEWACCT /qmdata/newacct`). The SSH host key for the container
is also stored in `/qmdata/ssh`, so it will remain the same across multiple
container runs if you use the same volume.

SSH key authentication
----------------------

If you wish to use SSH keys for authentication, add them to the
`/qmdata/ssh/keys-qmuser/authorized_keys` file after the container is started
for the first time. The SSH server is configured to use this location, and a
blank file is automatically created with the correct ownership and permission
attributes to satisfy sshd's requirements.

Setting the qmuser password
---------------------------

If you wish to specify a password for the qmuser user instead of randomly
generating one, use the same run command but with the `QMUSER_PASSWORD`
environment variable set:

```plaintext
$ mkdir qmdata
$ docker run --name openqm -d \
   -p 4222:22 -p 4242:4242 -p 4243:4243 \
   -v $(pwd)/qmdata:/qmdata \
   -e QMUSER_PASSWORD=letmein \
   racingmars/openqm:latest
```

Accessing the shell
-------------------

To access the shell as the qmuser user, run the `SH` command once you are
logged in to OpenQM **in an SSH session** (it *will not* work from a telnet
session).

To access the shell as root, use the following Docker command when the
container is running (where `openqm` is the container name in the `--name`
argument of original `docker run` command that started the container):

```plaintext
$ docker exec -it openqm bash
```

Shutting down
-------------

The container will cleanly stop OpenQM and the other running services in
response to a `docker stop` command. You can resume the container with the
`docker start` command and the services will restart and the existing qmuser
password will remain set to whatever it was previously.

If you remove the container (`docker rm`) and run a new container pointing to
the existing `/qmdata` volume, the qmuser user will have a new password,
either randomly generated or as set by the `QMUSER_PASSWORD` environment
variable, but all data in the existing QMSYS and QMUSER accounts (and any
other accounts you created) will remain.

Additional information
----------------------

The [Rush Flat][3] web site contains excellent information related to OpenQM,
including a two-part series of "Getting Started in OpenQM" books.

You can also find there downloadable [HTML help files][4] and [PDF reference
documentation][5].

[3]: https://www.rushflat.co.nz/multi-value
[4]: http://www.rushflat.co.nz/files/qmhelp_2-6-6.tar.gz
[5]: http://www.rushflat.co.nz/files/qmdocs_2-6-6.tar.gz
