OpenQM GPL Release 2.6-6
========================

The original authors of the OpenQM multivalue database system, Ladybridge
Systems, once released a GPL-licensed version of the Linux version of OpenQM.
The last version released under the GPL was 2.6-6. OpenQM was later acquired
by Zumasys, then Rocket Software, where it lives on as a proprietary
commercial product.

This repository begins with that last release. The first commit in this repo
contains, in the gpl.qmsys directory, the files as delivered in
qmsrc_2-6-6.tgz, downloaded from [a distribution archive][1], with two
modifications:

 1. The execute permission bit has been removed from files for which it
    isn't appropriate, and
 2. Empty .gitkeep files have been created in empty directories.

[1]: http://billabong-services.co.uk/anji/qm/qmsrc_2-6-6.tgz

Subsequent commits make small improvements and modifications on top of the
original 2.6-6 GPL release.

Note that this is old code, and requires a 32-bit environment. You probably
want to follow the dev branch of [ScarletDME][2], a community fork of the GPL
release of OpenQM which adds additional functionality and 64-bit architecture
support. I also have [my own fork of ScarletDME][3] that includes some fixes
and minor modifications.

[2]: https://github.com/geneb/ScarletDME/tree/dev
[3]: https://github.com/racingmars/ScarletDME

The help files and documentation for this version of OpenQM do not appear to
have been released under an open license, so are not in this repository. You
can find the [HTML help files][4] and [reference documentation][5] elsewhere
online.

[4]: http://www.rushflat.co.nz/files/qmhelp_2-6-6.tar.gz
[5]: http://www.rushflat.co.nz/files/qmdocs_2-6-6.tar.gz

The [Rush Flat][6] web site contains excellent information related to OpenQM,
including a two-part series of "Getting Started in OpenQM" books.

[6]: https://www.rushflat.co.nz/multi-value

Running with Docker
-------------------

For an easy-to-use Docker image for this version of OpenQM, see the docker
directory in this repository and the [Docker Hub listing][7] for this project.

[7]: https://hub.docker.com/r/racingmars/openqm

---

—Matthew Wilson <mwilson@mattwilson.org>, Nov. 2024
