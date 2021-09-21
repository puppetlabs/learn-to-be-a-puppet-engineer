# Dynamic Target Manipulation

Scatter-gather, reduction (i.e. leaving behind failed nodes but continuing with others) and other imperative orchestration techniques.

## Documentation

[The reboot plan does this](https://github.com/puppetlabs/puppetlabs-reboot/blob/main/plans/init.pp#L42)

This sort of logic will likely be more important when writing custom deployment policies than regular plans since for a custom deployment policy you might want to do things like,
give a plan a set of 100 nodes to deploy to then do one of the following:

* Deploy in batches of 10
* Deploy 1, then 5 then 20 then 100 etc. and stop if there is a failure
* Run Puppet up to 5 times until the nodes come back cleanly, then stop. If any nodes still have changes this should trigger a failure as the deployment is non-idempotent

## Education

Not really covered.

## Other

Not covered anywhere that I know of
