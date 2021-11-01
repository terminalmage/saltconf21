SaltConf 21 Demo
================

This project contains the SLS files used in the demo for my SaltConf 21 demo,
in which an SSL-encrypted open-source pastebin application is deployed.

The
[defaults.yml](https://github.com/terminalmage/saltconf21/blob/main/fiche/defaults.yml)
contains the default configuration for this demo. Pillar data in the same
relative structure will override the defaults.

Additionally, note that this demo has been written to be run on an Ubuntu 20.04
minion, and the defaults defined in the
[defaults.yml](https://github.com/terminalmage/saltconf21/blob/main/fiche/defaults.yml)
are written with that platform (and only that platorm) in mind. To run this on
another platform, either modify the defaults, or use Pillar data to override
them.

## Before Starting

This demo requires a machine accessible to the internet, with Salt installed.

Additionally, a DNS A record is necessary to use as the FQDN for the pastebin
application, and that A record must be pointed at the machine’s IP address.

## Obtaining an SSL Certificate

```
# salt fichedemo state.apply fiche.letsencrypt
```

## Build and Run the Application

```
# salt fichedemo state.apply fiche.letsencrypt
```

## Use Orchestration to Do Everything in One Run

Note that the target in the [orchestration
file](https://github.com/terminalmage/saltconf21/blob/main/fiche/orchestrate.sls)
is the minion ID assigned to the machine being used. This will need to be
adjusted to match the minion ID of your machine, should you attempt to run this
orchestration.

```
# salt-run state.orchestrate fiche.orchestrate
```
