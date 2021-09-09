# Hiera hierarchy design

## Documentation

I don't think there is any opinionated docs on hiera hierarchy design

## Education

Nope.

## Other

We have a few small things about hiera here:

* <https://github.com/puppetlabs/best-practices/blob/master/puppet-abstration-hiera.md>
* <https://github.com/puppetlabs/best-practices/blob/master/separate-hieradata-repository.md>
* <https://github.com/puppetlabs/best-practices/blob/master/use-of-environment-in-hiera-hierarchy.md>

Possibly the book [Puppet Best Practices](https://www.oreilly.com/library/view/puppet-best-practices/9781491922996/ch06.html) would be a good resource.

Also as part of the code review for basics three will involve looking at the hierarchy that someone has created and making sure that it makes sense.
Though to be fair there are certainly a few things that we could be missing here. e.g. how many layers should you have, what sorts of facts should be part of a hierarchy, what you should and shouldn't do regarding nesting of files, etc.
