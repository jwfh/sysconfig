# sysconfig

## Installation

This repository should be mounted at `/sysconfig` (or another location specified in `config.sh`) on all hosts.
I do this by cloning it on one server and mounting it read-only with NFS on all of the other servers.
The master server has a cron job to pull updates from Git.
My base image for all other servers includes an `fstab(5)` entry with the NFS mount.

## Adding a new server