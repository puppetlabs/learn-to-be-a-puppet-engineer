# Declarative Coding Concepts

Puppet is in the class of Domain Specific Languages that follow a declarative programming model. Declarative programming is often defined as any style of programming that isn't imperative, but that's not a very useful definition.

## DSL

Before looking at examples to aid our understanding, we should clarify what "Domain-specific language" means.

Again, this is often contrasted with General Purpose Languages, but the main difference is that DSLs are often not Turing-complete. (Though some [accidentally Turing Complete](https://www.gwern.net/Turing-complete))

Such restricted languages cannot solve all problems that a Turing Complete language can solve, but that's not the point. The power of Domain Specific Languages lies in easily solving _domain-specific problems_. In Puppet's case, that problem domain is configuring computers and software, and automating installations thereof on hundreds or thousands or more machines.

## Features

Another well-known DSL is Make. Its problem domain is that of building software.

What both have in common is that they rely heavily on a set of _predefined functionality_, and on the user structuring this functionality with _dependencies_.

They are also both _idempotent_, that is, they will not touch a _target_ (in Make) or a _resource_ (in Puppet), if it is already found to be in the correct state.

This idempotence and **_correctness_** is much easier to achieve when each resource/target is only defined once. This _uniqueness_ constraint is a lot stronger in Puppet: Make will only warn you when you redefine a target, Puppet will throw an error.

From these constraints, Make and Puppet build a DAG (Directed Acyclic Graph - Puppet's Logo!). Make uses it to heavily parallelize a build.

In Puppet, the DAG is used only to verify correctness, because parallelization might be impossible (API calls), or too error prone (package installation).

## Make

Let's take a look at Make. As mentioned before, Make has a lot of built-in rules.

To compile a simple C program such as this ``hello.c`` file,

```c
# include <stdio.h>

int main() {
    printf("Hello, World!\n");
    return 0;
}
```

we call ``make hello``:

```sh
meena@computer > make hello
cc     hello.c   -o hello
meena@computer >
```

Note that different Makes can have different defaults.

Here's the same run with BSD Make:

```sh
meena@computer > bmake hello
cc -pipe -O2 -o hello hello.c
meena@computer >
```

This isn’t a world-shaking difference, and is only something that systems-programmers may need to keep in mind, when porting their software to different systems.

We can now execute ``./hello`` and get a nice greeting of ``Hello, World!``. Crucially, if we run ``make hello`` again, we get:

```sh
meena@computer > make hello
make: `hello' is up to date.
meena@computer >
```

There's one clear advantage to putting these things into a ``Makefile``: we can define our own convenience targets, while re-using the built-in defaults:

```makefile
hello: hello.c
	$(CC) $(CFLAGS) -o hello hello.c

.PHONY: clean
clean:
	rm -f -- hello
```

Let’s start from the top: ``hello`` is our target, and it _depends_ on ``hello.c``. Previously, Make went looking for a dependency, and you can see this process (without a Makefile) by running ``make -d hello`` .

To build our ``hello`` _target_, we re-use the built-ins for ``$(CC)`` (the default system C Compiler) and ``$(CFLAGS)`` (flags passed to that C Compiler). These built-ins represent the knowledge inherent in Make, and also, in part, the _imperative_ parts. Using them we can focus on _declaring the intent_: What needs to be done? In roughly what order? This way, the _how_ can be left to magic.

``hello`` being the first target in the ``Makefile``, is also the _default_ target,

so we can now call ``make`` without parameters:

```sh
meena@computer > make
cc  -o hello hello.c
meena@computer > make
make: `hello' is up to date.
```

We now also declare a new, [`.PHONY`](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html) target called ``clean``. We often see a `clean` target and there cannot be a default for it, so we have to define our own. Our ``clean`` target is "``.PHONY``", because it produces nothing that Make can track. That means, that the ``clean`` target is _not idempotent_, we can run it as often as we want, and it will always (attempt to) delete our ``hello`` binary:

```sh
meena@computer > make clean
rm -f -- hello
meena@computer > make clean
rm -f -- hello
meena@computer > make clean
rm -f -- hello
meena@computer >
```

Make is very good at tracking things that exist, but not so good at tracking their purposeful absence. We can forgive Make this deficiency, after all, it's in the name: it's supposed to _make_ things.

### Dependencies

Let's extend our C program, 

```c
# include <stdio.h>

int main(int argc, const char **argv) {
    if (argc == 2) {
        printf("Hello, %s!\n", argv[1]);
    } else {
        printf("Hello, World!\n");
    }
    return 0;
}
```

and its Makefile to show-case dependencies:

```makefile
WHO ?= Mina Galić

greet: hello
	./hello "$(WHO)"

hello: hello.c
	$(CC) $(CFLAGS) -o hello hello.c

.PHONY: clean
clean:
	rm -f -- hello
```

Let's summarize this:

* Our new _default_ target is now ``greet``
* it depends on ``hello``, which
* depends on ``hello.c``.

That means: If ``hello.c`` changes, ``hello`` is recompiled.

The ``greet`` target then calls ``./hello`` to greet the author.

In addition, the ``WHO`` variable can be overridden (thanks to the ``?=`` assignment), to greet someone else:

```sh
meena@computer > make
cc  -o hello hello.c
./hello "Mina Galić"
Hello, Mina Galić!
meena@computer > make greet WHO="Someone Else"
./hello "Someone Else"
Hello, Someone Else!
meena@computer >
```

## Puppet

At first glance the many built-ins in Puppet make it seem quite magical too. One thing we can do is _query_ the system with Facter,

```json
# meena@computer > facter os
{
  architecture => "x86_64",
  family => "Darwin",
  hardware => "x86_64",
  macosx => {
    build => "20F71",
    product => "macOS",
    version => {
      full => "11.4.0",
      major => "11.4",
      minor => "0"
    }
  },
  name => "Darwin",
  release => {
    full => "20.5.0",
    major => "20",
    minor => "5"
  }
}
```

and the Resource Abstraction Layer:

```puppet
# meena@computer > puppet resource user mina.galic
user { 'mina.galic':
  ensure   => 'present',
  comment  => 'Mina Galić',
  gid      => 20,
  groups   => ['_appserveradm', '_appserverusr', '_lpadmin', 'admin'],
  home     => '/Users/mina.galic',
  password => '*',
  shell    => '/usr/local/bin/fish',
  uid      => 501,
}
```

This is very similar to other declarative querying systems like SQL:

```sql
select * from user where name='mina.galic';
> name        ensure     comment     gid    uid    home               shell
> ----------  ---------  ----------  -----  -----  -----------------  -------------------
> mina.galic  present    Mina Galić  20     501    /Users/mina.galic  /usr/local/bin/fish
```

_Types_ like ``user`` encompass parameters for all systems that Puppet can run on, but only display information about the system it actually does run on.

With this we can create users, files, directories and install packages and manage services on a vast array of Unix systems, as well as Mac OS and Windows. In the Puppet language, we don't tell the computer _how_ to install a package or start a service, we _declare the intent_ of doing that.

The _Providers_ of those types know _how_ to do that. We only tell it the name and the version:

```puppet
# install apache httpd
$package = $facts['os']['family'] ? {
  FreeBSD => 'apache24',
  Debian  => 'apache2',
  Windows => 'apache-httpd',
  Solaris => 'web/server/apache-24',
  default => 'httpd',
}

$service = $facts['os']['family'] ? {
  Windows => 'Apache',
  Solaris => '/network/http:apache24',
  default => $package,
}

package { $package:
  ensure => installed,
}

service { $service:
  ensure    => started,
  enabled   => true,
  subscribe => Package[$package],
}
```

Let's try to break this down into terminology we know:

* We query the system about itself,
* Based on the OS Family fact, we decide what the package name (``$package``) we need to install will be
* again, based on the OS Family fact, we decide what the service name (``$service``) we need to manage will be
* here we already have a good default: The package name!
* we can now install the package - we're happy with any version, so long as it's ``installed``)
* start the service, and enable it so it'll survive reboots

### Dependencies

The ``subscribe`` line needs its own breakdown, because here is where we handle our _dependencies_:

* make the ``service`` depend on the ``package``
* that means: the package will be installed first, then the service will be enabled
* make the ``service`` _subscribe_ to the ``package``
* that means: when the package changes, the service will be restarted!

If we ran this Puppet manifest on 17 machines with 17 different OSes, we should end up with Apache HTTPD installed and running on most of them. And a more or less useful error-report from the ones where it failed!

That was a very long summary of what we did do. Let's briefly summarize what we didn't do:

* We didn't open a shell, and
* We didn't run ``apt``/``yum``/``dnf``/``brew``/``pkg``/``chocolatey``/etc ``install``
* We didn't run ``systemctl``/``service``/``launchctl``/``svc``/etc

Most importantly, we didn't do that on 17 machines!

## Uniqueness

We've mentioned before that Make _encourages_ uniqueness of its targets, while Puppet enforces it. In Puppet, this uniqueness constraint is also extended to variable assignments.

Let's look at why this might be useful. 

If we have two variable assignments in our Makefile:

```makefile
WHO ?= Mina Galić
WHO = Who Could This Be

greet: hello
	./hello "$(WHO)"

hello: hello.c
	$(CC) $(CFLAGS) -o hello hello.c

.PHONY: clean
clean:
	rm -f -- hello
```

It's impossible to tell what's going to happen, and different things may happen in different contexts:

```sh
meena@computer > make greet
Hello, Who Could This Be!
meena@computer > make greet WHO="Magic Lovers"
Hello, Magic Lovers!
meena@computer >
```

This guess-work is taken away in Puppet, by making reassignment impossible:

```puppet
$var = 'blah'
$var = 'blubb'
```

results in:

```
Error: Evaluation Error: Cannot reassign variable '$var' (file: var.pp, line: 2, column: 6) on node computer
```

That means that variables in Puppet are like variables in Mathematics, or Erlang: Names for an expression.

This constraint means that we can't reuse a single vessel, for all our trailing thoughts just because it seems familiar. We have to come with new names, often for similar concepts.

# Converting Shell Scripts into Declarative Code

The Internet's favorite "Ops" anti-pattern is ``curl | sudo bash``, because it easily relegates **root** control to a script that hardly anyone reviews, and even if they did, there's a way for a server to tell if they are being [piped or downloaded](https://www.idontplaydarts.com/2016/04/detecting-curl-pipe-bash-server-side/).

A good way to see if we understand what Declarative Coding Concepts are, would be to take such a popular script and see if we can convert it.

So let's take a look at [Nodesource](https://nodesource.com/)'s [RPM](https://rpm.nodesource.com/setup_16.x)  or [Apt](https://deb.nodesource.com/setup_16.x) install script, to setup NodeJS.

## Homework

* Pick one or both scripts
* identify _Checkpoints_
* identify _Dependencies_
* identify _Breakpoints_
* Which parts of the script can discarded?
* Which parts, if any, can be reused?
* Which parts, if any, can be replaced with Facter's knowledge?
* Which parts, if any, can be replaced with Puppet Modules or builtins?
