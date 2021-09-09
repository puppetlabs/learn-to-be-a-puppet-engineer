# PE Micro Architecture: Certificate authority

## Documentation

- [Intermediate CA](https://puppet.com/docs/puppet/latest/server/intermediate_ca.html)
- [Use an independent intermediate certificate authority](https://puppet.com/docs/pe/latest/use_an_independent_intermediate_ca.html)
- [Change the hostname of a primary server](https://puppet.com/docs/pe/2021.2/change_hostname_primary.html)

## Education

Definitely not covered.

## Other

I'd say that the overall structure is reasonably well covered in the docs.
It might be worth getting people to practice creating custom CAs with this tooling and integrating it with PE: https://github.com/dylanratcliffe/puppet_ca_gen

It is very, very rare that we are required to integrate with an internal CA, but it is common for PSE to have to talk customers out of it.
**This should maybe be homework...**
That conversation usually goes something like this:

* So usually we create a CA just for Puppet. It uses these certificates for its own authentication and nothing more
  * It doesn't add them into the trust store of the server
  * It doesn't affect anything other than Puppet
* If you were to use your own CA, that CA is trusted by the entire org right?
* Well if your CA is issuing certs that are trusted by the entire org, that means that the certs that Puppet uses will end up being trusted by the entire org
* Puppet needs a certificate for every server so you're talking about creating thousands of extra certs, all of which are trusted by your org
* Surely this is substantially less secure since you're massively expanding your surface area. If you leave it the default way you don't need to trust anything new. Puppet will just do its own thing with these certs and you can ignore that they are there
