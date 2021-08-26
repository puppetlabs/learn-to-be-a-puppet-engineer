# Puppet Language

## Language constructs

- [Resource type syntax](puppet/resource-type-syntax.md)
- Conditional logic
- [Variables and scope](puppet/variables-and-scope.md)
- Data types
- Defined types
- Advanced function usage (lambdas)
- Puppet-language functions
- [Relationships and ordering](puppet/relationships-and-ordering.md)

## [Declarative coding concepts](declarative/)

- [Resource idempotence](declarative/idempotence/)
- Resource uniqueness
- The type, title and namevar of a resource
- The types and providers abstraction layer
- Idempotent exec resources

## Tasks

- Passing parameters
- Parring parameters using powershell (fairly different)
- Returning data from tasks
- Secure coding practices (avoiding code injection attacks)

## Plans

- Basic plan writing
- Exception handling in plans
- Scatter-gather, reduction (i.e. leaving behind failed nodes but continuing with others) and other imperative orchestration techniques
- Returning data from a plan
- Composition of plans (plans that run plans)

# Ruby

## Ruby basics

- Debugging & exploring ruby using pry (Use this to begin teaching people since they will be used to using a REPL and Pry is nice and UNIX-ey)
- Conditional logic
- Variables and scope
- Data types
- Object-orientated programming

## Puppet-specific ruby

- Custom facts
- Custom functions
- Rspec-puppet and testing
- Types and providers
- Puppet faces?
- Custom report processors?
- Custom hiera backends?

# Puppet Enterprise

## Architecture

- [Installing PE](puppet-enterprise/installing-pe.md)
- Macro architecture i.e. compilers, primary, secondary
- Micro architecture, what services do, how they are configured, what are their dependencies, are they stateful or stateless, can they be load-balanced, how are they made HA?
   - ACE-Server
   - Bolt-Server
   - Orchestration-services
   - PXP
   - Puppetserver
   - Console-services
   - RBAC
   - Certificate authority
   - Puppetdb
   - Postgresql
   - Code manager
   - File sync
- Tuning and scaling, typical load patterns
- Proxies and their effect on PE communications
- Log location and how to configure more detailed logging
- Common debugging tools and methods
- Metrics ingestion from support script using Support’s tooling
- Postgres debugging using pgbadger
- Garbage collection analysis using gceasy.io

## APIs

- Which API endpoints are available and what they do
- How APIs are used in the normal operation of Puppet
- Puppet DB queries & PQL

# Coding Best Practices

- Style and naming conventions
- [The roles and profiles pattern](coding-best-practice/roles-and-profiles.md)
- Component modules and how they are different from profiles
- Composition of profiles to reduce duplication (i.e. profile::base vs profile::base::windows)
- [Data separation using hiera](coding-best-practice/data-separation-using-hiera.md)
- Hiera hierarchy design (how many layers, common patterns etc.)
- [Handling of sensitive data](coding-best-practice/handling-sensitive-data.md)

# Workflow

- [Git workflows using r10k](workflow/git-workflow-r10k.md)
- Workflows using CD4PE
- Custom deployment policies to implement advanced deployments
