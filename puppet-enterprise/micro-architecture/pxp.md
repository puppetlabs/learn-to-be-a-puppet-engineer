# PE Micro Architecture: PXP

## Documentation

<https://github.com/puppetlabs/pxp-agent>

## Education

Definitely not covered.

## Other

There's not a whole lot that you need to know about this.
It's worth reading the readme but it's pretty basic and kind of just works.
I would expect a principal to have a good idea of the insides but otherwise of if necessary

One thing that everyone should know though is the fact that PXP connects using in **inbound** connection and hold this connection open rather than Puppet connecting out to the PXP agent a la Ansible.
Important for firewall rules
