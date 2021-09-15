# Workflows using CD4PE

## Documentation

<https://puppet.com/docs/continuous-delivery/latest/deployment_policies.html>

## Education

This is also not covered in any education material.

## Other

We should have some kind of a standard framework for what we recommend in terms of workflows and pipelines when customers are using CD4PE.
[This confluence page](https://confluence.puppetlabs.com/display/PS/Puppet+Workflows) shows some examples of reasonable workflows from different points on the spectrum when using code manager, however these don't really apply to CD4PE.

Ideally we would create some content that covers the following:

* An example of a very lightweight workflow, preferably for a single small team with very little change control overhead and a fast deployment cadence
* An example for a very heavyweight workflow for a single team with a large amount of change control overhead and a slow deployment cadence
* An example of how to deal with many teams. How can their workflows be separated in CD4PE?

The things that each of these workflows should cover would be:

* What automated testing should be done and at which point/points in the pipeline?
* Where should impact analysis be placed?
* What happens if there is a problem found in production that requires a quick fix?
