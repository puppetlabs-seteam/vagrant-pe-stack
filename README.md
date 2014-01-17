# Vagrant Puppet Enterprise Stack

#### Table of Contents

1. [Overview](#overview)
2. [Setup](#setup)
    * [Plugins](#plugins)
    * [Installation](#installation)
    * [Optional: Snapshots](#optional--snapshots)
    * [Optional: Restricted Boxfiles](#optional--snapshots)
3. [Usage](#usage)
4. [Reference](#reference)

## Overview

This repository is a Vagrant configuration and associated Puppet code to spin
up a self-contained demonstration environment. The demonstration environment
will include a variety of pre-defined environments for demonstrating Puppet
Enterprise functionality and use cases.

The [Oscar](https://github.com/adrienthebo/oscar) vagrant plugin is used to
provide YAML based configuration, Puppet Enterprise provisioning, networking,
and name resolution.

The [vagrant-windows](https://github.com/WinRb/vagrant-windows) vagrant plugin
is used to provide Windows support.

The [vagrant-multiprovider-snap](https://github.com/scalefactory/vagrant-multiprovider-snap)
plugin can optionally be used to provide support for creating and rolling back
snapshots.

## Setup

### Plugins

Install VirtualBox 4.2 or newer and Vagrant 1.3 or newer. The following plugins
are also required.

    vagrant plugin install oscar
    # optionially if you are using windows:
    vagrant plugin install vagrant-windows

### Installation

Using the Vagrant PE Stack is as simple as performing a `git clone` on the repo
and running `vagrant up`. A full example checkout and initialization is given
below.

    git clone git@github.com:puppetlabs-seteam/vagrant-pe-stack.git
    cd vagrant-pe-stack

Vagrant pe-build plugin needs a copy of the PE installer.

Download the installer from: http://info.puppetlabs.com/download-pe.html

Copy the installer into the vagrant pe-build environment with the command:

    vagrant pe-build copy path/to/installer.tar.gz

You can use the -all tarball (which is gigantic) or just the build for each platform
you have installed. Modify the config/pe\_uild.yaml set the desired version as well.

From this point forward everything is a standard Vagrant workflow. Commands
like `vagrant list` will show you the machines defined and avaialble, and
machines can be brought up with `vagrant up` as per usual.

    vagrant up master

### Optional: Snapshots

The vagrant-multiprovider-snap can be installed in order to provide the ability
to easily snapshot and rollback virtual machine instances.

    vagrant plugin install vagrant-multiprovider-snap

### Optional: Restricted Boxfiles

This Vagrant environment contains references to several commercial platforms.
These platforms are Windows Server 2008 R2, SuSE Linux Enterprise Server 11,
and Solaris 10. In order to use this environment to spin up and use Puppet
Enterprise on these platforms, an appropriate boxfile must first be created or
obtained.

More information on creating boxfiles for Windows, Solaris and SLES may be found online.

Resources:

* https://github.com/jedi4ever/veewee/
* https://github.com/WinRb/vagrant-windows#creating-a-base-box
* http://www.packer.io/intro/getting-started/vagrant.html

## Usage

The things included with the vagrant-pe-stack that make it more interesting
than just Oscar are the Puppet environments and modules that are automatically
deployed with the stack that demonstrate functionality of Puppet Enterprise.

The vagrant-pe-stack uses [Dynamic
Environments](http://puppetlabs.com/blog/git-workflow-and-puppet-environments),
implemented using [r10k](https://github.com/adrienthebo/r10k). Each environment
contains a set of Puppet Modules, typically deployed in a [Roles &
Profiles](http://www.craigdunn.org/2012/05/239/) configuration. A README file
in the root directory of the environment will contain instructions on what the
environment does, and how to use it.

The Puppet Enterprise Console is used to define which environment to deploy.
The [jay/console_env](http://forge.puppetlabs.com/jay/console_env) module is
used on the master, which enables the environment parameter to be set in the
Console.

Typical environment deployment will consist of

1. Set the environment parameter for the default group in the console.
2. Classify nodes with the roles (from the specified environment) that you
   would like to manage.
3. Run Puppet on the nodes using either Live Management or the `mco` command on
   the Puppet master system.

# Reference

Notes about implementation details may be added here at a later date. Until
then, perusing the code is the best reference for how things have been
implemented.
