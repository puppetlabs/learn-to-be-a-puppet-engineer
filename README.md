# Puppet Language

## Language constructs

- [Resource type syntax](puppet/resource-type-syntax.md)
- [Conditional logic](puppet/conditional-logic.md)
- [Variables and scope](puppet/variables-and-scope.md)
- [Data types](puppet/data-types.md)
- [Defined types](puppet/defined-types.md)
- [Advanced function usage (lambdas)](puppet/lambdas.md)
- [Puppet-language functions](puppet/puppet-language-functions.md)
- [Relationships and ordering](puppet/relationships-and-ordering.md)

## [Declarative coding concepts](declarative/)

- [Resource idempotence](declarative/idempotence/)
- Resource uniqueness
- [The type, title and namevar of a resource](declarative/type-title-namevar.md)
- The types and providers abstraction layer
- [Idempotent exec resources](declarative/idempotence/exec-resources.md)

## Tasks

- [Passing parameters](tasks/passing-parameters.md)
- [Passing parameters using powershell](tasks/passing-parameters-powershell.md)
- Returning data from tasks
- [Secure coding practices](tasks/secure-code-practices.md)

## Plans

- [Basic plan writing](plans/basic-plan-writing.md)
- [Error handling in plans](plans/error-handling-in-plans.md)
- [Scatter-gather, reduction](plans/scatter-gather-reduction.md)
- [Returning data from a plan](plans/returning-data-from-plans.md)
- [Composition of plans](plans/composition-of-plans.md) (plans that run plans)

# Ruby

## [Ruby basics](ruby/README.md)

- Debugging & exploring ruby using pry (Use this to begin teaching people since they will be used to using a REPL and Pry is nice and UNIX-ey)
- Conditional logic
- Variables and scope
- Data types
- Object-orientated programming

## Puppet-specific ruby

- [Custom facts](puppet-ruby/custom-facts.md)
- [Custom functions](puppet-ruby/custom-functions.md)
- [Rspec-puppet and testing](puppet-ruby/rspec-puppet-testing.md)
- [Testing using Litmus](puppet-ruby/testing-using-litmus.md)
- [Types and providers](puppet/types-and-providers.md)
- [Custom report processors](puppet-ruby/custom-report-processors.md)
- [Custom hiera backends](puppet-ruby/custom-hiera-backends.md)
- [Puppet faces?](puppet-ruby/puppet-faces.md)

# Puppet Enterprise

## Architecture

- [Installing PE](puppet-enterprise/installing-pe.md)
- [Macro architecture](puppet-enterprise/macro-architecture.md) i.e. compilers, primary, secondary
- [Micro architecture](puppet-enterprise/micro-architecture/), what services do, how they are configured, what are their dependencies, are they stateful or stateless, can they be load-balanced, how are they made HA?
   - [ACE-Server](puppet-enterprise/micro-architecture/ace-server.md)
   - Bolt-Server
   - [Orchestration-services](puppet-enterprise/micro-architecture/orchestration-services.md)
   - PXP
   - [Puppetserver](puppet-enterprise/micro-architecture/puppet-server.md)
   - Console-services
   - RBAC
   - [Certificate authority](puppet-enterprise/micro-architecture/certificate-authority.md)
   - [Puppetdb](puppet-enterprise/micro-architecture/puppet-db.md)
   - [Postgresql](puppet-enterprise/micro-architecture/postgresql.md)
   - [Code manager](puppet-enterprise/micro-architecture/code-manager.md)
   - File sync
- Tuning and scaling, typical load patterns
- Proxies and their effect on PE communications
- Log location and how to configure more detailed logging
- Common debugging tools and methods
- Metrics ingestion from support script using Support’s tooling
- Postgres debugging using pgbadger
- Garbage collection analysis using gceasy.io

## APIs

- [Which API endpoints are available and what they do](apis/)
- [How APIs are used in the normal operation of Puppet](apis/how.md)
- [Puppet DB queries & PQL](apis/puppet-db-queries-pql.md)

# Puppet Application Manager

- [Kubernetes](pam/kubernetes.md)
- [Installing CD4PE](pam/install-cd4pe.md)
- [Installing Comply](pam/install-comply.md)

# Coding Best Practices

- [Style and naming conventions](coding-best-practice/style-and-naming-conventions.md)
- [The roles and profiles pattern](coding-best-practice/roles-and-profiles.md)
- Component modules and how they are different from profiles
- Composition of profiles to reduce duplication (i.e. profile::base vs profile::base::windows)
- [Data separation using hiera](coding-best-practice/data-separation-using-hiera.md)
- [Hiera hierarchy design](coding-best-practice/hiera-hierarchy-design.md)
- [Handling of sensitive data](coding-best-practice/handling-sensitive-data.md)

# Workflow

- [Git workflows using r10k](workflow/git-workflow-r10k.md)
- [Development Practices for Ops](workflow/dev-practices-for-ops.md)
- [Workflows using CD4PE](workflow/workflows-using-cd4pe.md)
- [Custom deployment policies to implement advanced deployments](workflow/custom-deployment-policies.md)
