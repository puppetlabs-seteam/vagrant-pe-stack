Console_Env
-------
This only works with the Puppet Enterprise Console

This is the console_env module. It was written with the sole purpose of adding the ability to specify environments in the console using key/value pairs.

This module is merely a temporary solution, to set environments without having to use an alternative ENC.

Usage
-------
Include this module on your Console node:

`include console_env`

By default the ensure value for the console_env class is set to present

Under the hood the module is using an awk script extracting the value for the environment parameter if it exists, if the environment
parameter is found it is appends it to the environment stanza at the bottom of what is returned via the ENC scripts curl.

Now you are able to specify the environment for individual nodes and groups in the console using the key value pair of:

environment => your_environment

Make sure to make all the proper adjustments in `/etc/puppetlabs/puppet/puppet.conf` specified in the [environment guide](http://docs.puppetlabs.com/guides/environment.html)


Contact
-------
jay@puppetlabs.com

Repo
-------

Please submit any pull request to [console-env repo](https://github.com/revhazroot/console_env/)
