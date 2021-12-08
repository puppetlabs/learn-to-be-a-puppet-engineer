---
breaks: false
title: Exploring Ruby with Pry
tags: skills-map
---

# Exploring Ruby with Pry

## Using Pry

Before we can get started with pry, we need to install it, see if it works, and configure it so it works a little better.

### Install

Pry is installed as `gem`.
In order to install it to be used with Puppet and Bolt, we need to install it in their environment:

```shell
meena@ubuntix ~> sudo -H /opt/puppetlabs/bolt/bin/gem install pry pry-doc
Fetching pry-0.14.1.gem
Successfully installed pry-0.14.1
Parsing documentation for pry-0.14.1
Installing ri documentation for pry-0.14.1
Done installing documentation for pry after 0 seconds
Fetching pry-doc-1.2.0.gem
Successfully installed pry-doc-1.2.0
Parsing documentation for pry-doc-1.2.0
Installing ri documentation for pry-doc-1.2.0
Done installing documentation for pry-doc after 0 seconds
2 gems installed
meena@ubuntix ~>
```

and the same for for Puppet, with `/opt/puppetlabs/bolt/bin/gem install pry pry-doc`.

You may notice that we're installing pry and pry-doc.
[pry-doc](https://github.com/pry/pry-doc) provides us with documentation and source code of the core ruby.
This is immensely useful and powerful.

If you want to do the same for all your Rubies in a PDK install, you can do something like:

```fish
meena@ubuntix ~> for gem in /opt/puppetlabs/pdk/private/ruby/*/bin/gem
                     sudo -H $gem install pry pry-doc
                 end
```

### Starting Pry

To start pry, you can now:

```
meena@ubuntix ~> /opt/puppetlabs/bolt/bin/pry
[1] pry(main)>
```

If you're planning to do something that only root can do with Puppet in Pry, you should prefix that command with `sudo -H`.

We can now test some basics:

```ruby
[1] pry(main)> module PryingOpen
[1] pry(main)*   def self.my_third_eye
[1] pry(main)*     "ꙮ Welcome ꙮ Explorer ꙮ"
[1] pry(main)*   end
[1] pry(main)* end
=> :hello
[2] pry(main)> PryingOpen.my_thid_eye
=> "ꙮ Welcome ꙮ Explorer ꙮ"
[3] pry(main)>
```

And thanks to 'pry-doc', we can look up documentation for things we have forgotten!

```ruby
[6] pry(main)> ? "".length
Error: Cannot locate this method: length. Invoke the 'gem-install pry-doc' Pry command to get access to Ruby Core documentation.
```

or maybe not…
maybe we actually need to read [pry-doc](https://github.com/pry/pry-doc)'s documentation, and learn that we need to `require 'pry-doc'`, in order to use it:

```ruby
[7] pry(main)> require 'pry-doc'
=> true
[8] pry(main)> ? "".length

From: string.c (C Method):
Owner: String
Visibility: public
Signature: length()
Number of lines: 7

Returns the character length of str.

VALUE
rb_str_length(VALUE str)
{
    return LONG2NUM(str_strlen(str, NULL));
}
[9] pry(main)>
```

That's much better!

### Configuring Pry

Often we'll forget about that step, and get really annoyed at pry or ourselves, so to make our lives a lot easier, we can create a [pryrc](https://github.com/pry/pry/wiki/Customization-and-configuration), which auto-loads pry-doc:

```shell
root@ubuntix:~# mkdir -p .config/pry
root@ubuntix:~# echo "require 'pry-doc'" > .config/pry/pryrc
root@ubuntix:~#
```

If we're juggling a lot of different pry sessions, we might also wanna set:

```ruby
pry_instance.config.prompt_name = 'my_project_name'
```

within each session, to easier distinguish them.

It's also good to set your favorite editor, for example:

```ruby
Pry.config.editor = 'nvim'
```

And with that, we're ready to revisit some ruby basic and essentials:

## Ruby Basics and Essentials

To people who don't know Ruby, and might even be somewhat new to programming in general, I highly recommend having a book for *children* as a guide.

[Ruby Wizardry](https://nostarch.com/rubywizardry) is such a book, and it's absolutely beautiful.

I highly recommend walking thru the book, using `pry` instead of `irb`.

### Learning how to explore

While walking thru a book like Ruby Wizardry in pry, the easiest way we can learn more about Ruby is to issue `?` on everything new in the book, whether we believe that we know it or not does not matter.

For example:

```ruby
[9] pry(main)> ? puts

From: io.c (C Method):
Owner: Kernel
Visibility: private
Signature: puts(*arg1)
Number of lines: 12

Equivalent to

    $stdout.puts(obj, ...)

static VALUE
rb_f_puts(int argc, VALUE *argv, VALUE recv)
{
    if (recv == rb_stdout) {
        return rb_io_puts(argc, argv, recv);
    }
    return rb_funcallv(rb_stdout, rb_intern("puts"), argc, argv);
}
[10] pry(main)>
```

if the Ruby core source-code feels like to much information for now, you can try to tune it out and only observe it passively.

However, it is exactly this feature of pry when exploring a complex project that is immensely useful.

Sometimes this doesn't work very well:

```ruby
[10] pry(main)> ? 22
Error: Couldn't locate a definition for 22
[11] pry(main)>
```

in these cases, we can `cd` into the object!

```ruby
[11] pry(main)> cd 22
[12] pry(22):1> ls
Comparable#methods: between?  clamp
Numeric#methods:
  +@    angle  clone  conjugate  eql?     i     imaginary  negative?  phase  positive?     pretty_print_cycle  real   rect         singleton_method_added  to_c
  abs2  arg    conj   dup        finite?  imag  infinite?  nonzero?   polar  pretty_print  quo                 real?  rectangular  step                    zero?
Integer#methods:
  %   +   <    ==   >>       abs         ceil         digits  even?  gcdlcm    magnitude  numerator  pred         size   to_i    truncate
  &   -   <<   ===  []       allbits?    chr          div     fdiv   inspect   modulo     odd?       rationalize  succ   to_int  upto
  *   -@  <=   >    ^        anybits?    coerce       divmod  floor  integer?  next       ord        remainder    times  to_r    |
  **  /   <=>  >=   __pry__  bit_length  denominator  downto  gcd    lcm       nobits?    pow        round        to_f   to_s    ~
locals: _  __  _dir_  _ex_  _file_  _in_  _out_  pry_instance
[13] pry(22):1>
```

and sometimes, we just can't get the documentation for a specific thing:

```ruby
[13] pry(22):1> ? if
Error: Couldn't locate a definition for if
[14] pry(22):1>
```

and then other times we might just hit a real wall:

```ruby
[14] pry(22):1> ? else
Traceback (most recent call last):
        19: from /opt/puppetlabs/puppet/bin/pry:23:in `<main>'
        18: from /opt/puppetlabs/puppet/bin/pry:23:in `load'
        17: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/bin/pry:13:in `<top (required)>'
        16: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/cli.rb:112:in `start'
        15: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/pry_class.rb:188:in `start'
        14: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/repl.rb:15:in `start'
        13: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/repl.rb:38:in `start'
        12: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/input_lock.rb:78:in `with_ownership'
        11: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/input_lock.rb:61:in `__with_ownership'
        10: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/repl.rb:38:in `block in start'
         9: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/repl.rb:67:in `repl'
         8: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/repl.rb:67:in `loop'
         7: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/repl.rb:68:in `block in repl'
         6: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/repl.rb:105:in `read'
         5: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/indent.rb:146:in `indent'
         4: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/indent.rb:146:in `each'
         3: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/indent.rb:160:in `block in indent'
         2: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/indent.rb:160:in `times'
         1: from /opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/indent.rb:160:in `block (2 levels) in indent'
/opt/puppetlabs/puppet/lib/ruby/gems/2.7.0/gems/pry-0.14.1/lib/pry/indent.rb:160:in `sub!': can't modify frozen String: "" (FrozenError)
meena@ubuntix ~ [1]>
```

all of this is part of exploring and learning our tools' limits.

### Basics

#### Unicode

Being initially developed in Japan, Ruby has full-fledged Unicode support:

```ruby
[63] pry(main)> ć = :acute_c
=> :acute_c
[65] pry(main)> acute_c = :ć
=> :ć
```

#### Expressions

After looking at this many pry sessions, perhaps one thing has become clear now:
**Everything** in Ruby returns *something*.
This is because Ruby is an [Expression](https://en.wikipedia.org/wiki/Expression_(programming)) (even [Statements](https://en.wikipedia.org/wiki/Statement_(programming))).

#### Conditions and Functions

Since everything is an expression, conditionals are often (shortened and) used for assignment:

```ruby
[66] pry(main)> acute_c = :Ć if acute_c == :ć # toggle once
=> :Ć
[68] pry(main)> acute_c = if acute_c == :ć then :Ć else :ć end # toggle always
=> :ć
[69] pry(main)> acute_c = if acute_c == :ć then :Ć else :ć end # toggle always
=> :Ć
```

Instead of copying the same line over and over again, we could pack that into the smallest form of encapsulation / abstraction Ruby has: A function.

```ruby=
acute_c = :Ć

def toggle_acute_c()
    acute_c = if acute_c == :ć
        :Ć
    else
        :ć
    end
    acute_c
end
```

```ruby
[131] pry(main)> toggle_acute_c()
=> :ć
[132] pry(main)> acute_c
=> :Ć
[133] pry(main)> acute_c
=> :Ć
[134] pry(main)> toggle_acute_c()
=> :ć
[135] pry(main)> acute_c
=> :Ć
```

well, that's strange! It's almost as if our global `acute_c` and the `acute_c` in the function `toggle_acute_c` are completely independent!
And they are!
[Global variables](https://ruby-doc.org/docs/ruby-doc-bundle/UsersGuide/rg/globalvars.html) in Ruby need a `$` prefix, and they are very much [frowned upon](https://docs.rubocop.org/rubocop/cops_style.html#styleglobalvars).

We'll look into better ways of dealing with Data and Scope later, but for now, let's just quick-fix our code:

```ruby
$acute_c = :Ć

def toggle_acute_c()
    $acute_c = if $acute_c == :ć
        :Ć
    else
        :ć
    end
    $acute_c
end
```

or, completely in pry, using the `edit` command:

```ruby
[144] pry(main)> edit toggle_acute_c
[145] pry(main)> toggle_acute_c()
=> :ć
[146] pry(main)> toggle_acute_c()
=> :Ć
[147] pry(main)>
```

Try and see if you can get rid of that last `$acute_c` at the end, since the entire `if/else` should already return the same thing!

#### Loops and Blocks

There are loops ways to loop in Ruby: Loops and iterators.

There are several built-in loop constructs, such as [`for`, `while`/`until`](http://ruby-doc.com/docs/ProgrammingRuby/html/tut_expressions.html#S6), and [Iterators](https://ruby-doc.com/docs/ProgrammingRuby/html/tut_expressions.html#UJ).

The key difference is what they return.
For example: `for` returns the object it iterated over:

```ruby
[48] pry(main)> for i in 1..3
[48] pry(main)*   i
[48] pry(main)* end
=> 1..3
```

`while`/`until` return `nil`:

```ruby
[46] pry(main)> while false
[46] pry(main)* end
=> nil
[47] pry(main)> until true
[47] pry(main)* end
=> nil
```

Except, that everything can be made to return something else with `break`:

```ruby
[44] pry(main)> while :the_music_plays
[44] pry(main)*   break :dance
[44] pry(main)* end
=> :dance
[45] pry(main)> for i in 1..4
[45] pry(main)*   break 17
[45] pry(main)* end
=> 17
```

Higher order functions working on iterators return whatever the function says it returns.

The `each` family generally either returns `self` or a *new* iterator:

```ruby
[69] pry(main)> x = 1..4
=> 1..4
[70] pry(main)> x.each {|i| i}
=> 1..4
```

The map and collect family generally return an array of each processed item (or, again, a new iterator, if no block was passed):

```ruby
[5] pry(main)> x.map {|i| i}
=> [1, 2, 3, 4]
[6] pry(main)> x.collect {|i| i}
=> [1, 2, 3, 4]
[7] pry(main)>
```

This can be quite tedious, if some or many of the objects are `nil`:

```ruby
[8] pry(main)> x.map {|i| i.odd?}
=> [true, false, true, false]
[9] pry(main)> x.map {|i| i if i.odd?}
=> [1, nil, 3, nil]
[10] pry(main)> x.map {|i| i if i.odd?}.compact
=> [1, 3]
```

In these cases, we can use `select`:

```ruby
[11] pry(main)> x.select {|i| i.odd?}
=> [1, 3]
```

If all an iterator function's block does is take the running argument and call a single function with no parameters on it, there's even a shortcut for that in Ruby:

```ruby
[12] pry(main)> x.select(&:odd?)
=> [1, 3]
```

That might be a little bit too dense, so you might wanna use it sparingly.

Alternatively, starting Ruby 2.7, you can use:

```ruby
[53] pry(main)> x.select{_1.odd?}
=> [1, 3]
[54] pry(main)>
```

And of course, just like with loops, all blocks can be made to return anything with `break`:

```ruby
[15] pry(main)> x.reduce {break :no}
=> :no
```

### Modules, Classes and Scope

The [Ruby Basics](https://bparanj.gitbooks.io/ruby-basics/content/) (Git)Book, has a beautiful chapter [explaining Class, Object and Module Hierarchy](https://bparanj.gitbooks.io/ruby-basics/content/third_chapter.html).
I highly suggest reading this, as in this bit here, we will only focus on Scope.

But here's a partial summary:

```ruby
[168] pry(main)> name
=> :Mina_Galić
[169] pry(main)> name.class
=> Symbol
[170] pry(main)> Symbol.superclass
=> Object
[171] pry(main)> Symbol.superclass.superclass
=> BasicObject
[172] pry(main)> Symbol.superclass.superclass.superclass
=> nil
```
although, `Module` is, perhaps confusingly, a `Class`:

```ruby
[180] pry(main)> Module.class
=> Class
```

Modules are separate beast: They are mostly used to form Namespaces.
Sometimes they just provide a namespace of useful functions that don't seem to make sense in an object oriented world

### Essentials

By now, you may have noticed that everything in Ruby is an object.
Ruby is a programming language in the tradition of [Smalltalk](http://wiki.c2.com/?SmalltalkLanguage).
In Smalltalk, everything is an object, and objects pass messages to each other.

Generally, Smalltalk takes this a step further and has no language keywords for conditionals and loops.
They are instead messages (methods) on top of Boolean objects (with Syntactic Sugar).
Whereas Ruby's other *initial* influence was Perl (and Unix).
You can see this in the fact that Ruby has [`BEGIN`/`END` blocks](https://scoutapm.com/blog/ruby-begin-end) and in the fact that everything is file based, not image based, like in Smalltalk.

A lot of essentials are in the [`Kernel` Module](https://ruby-doc.org/core/Kernel.html):

```ruby
[198] pry(main)> ls Kernel
constants: RUBYGEMS_ACTIVATION_MONITOR
Kernel.methods:
  Array    Pathname    __dir__     autoload      caller_locations  exit!   global_variables  loop   printf  rand              select          srand    trace_var
  Complex  Rational    __method__  autoload?     catch             fail    iterator?         open   proc    readline          set_trace_func  syscall  trap
  Float    String      `           binding       eval              fork    lambda            p      putc    readlines         sleep           system   untrace_var
  Hash     URI         abort       block_given?  exec              format  load              pp     puts    require           spawn           test     warn
  Integer  __callee__  at_exit     caller        exit              gets    local_variables   print  raise   require_relative  sprintf         throw
Kernel#methods:
  !~     define_singleton_method  freeze                      instance_variable_get  method           protected_methods         send               tap      untrust
  <=>    display                  frozen?                     instance_variable_set  methods          public_method             singleton_class    then     untrusted?
  ===    dup                      hash                        instance_variables     nil?             public_methods            singleton_method   to_enum  yield_self
  =~     enum_for                 inspect                     is_a?                  object_id        public_send               singleton_methods  to_s
  class  eql?                     instance_of?                itself                 pretty_inspect   remove_instance_variable  taint              trust
  clone  extend                   instance_variable_defined?  kind_of?               private_methods  respond_to?               tainted?           untaint
[199] pry(main)>
```

but the two most important ones are [`send`](https://ruby-doc.org/core/Object.html#method-i-send) in [`Object`](https://ruby-doc.org/core/Object.html) and [`method_missing`](https://ruby-doc.org/core/BasicObject.html#method-i-method_missing) in [`BasicObject`](https://ruby-doc.org/core/BasicObject.html)

Let's look at `send` first:

```ruby
[193] pry(main)> 1.2.send(:+, 1.2)
=> 2.4
[194] pry(main)> 1.2.send(:+, 2.2)
=> 3.4000000000000004
```

Oh computers… wouldn't it be nice, if they knew [how to… compute](https://floating-point-gui.de/)?

The [`method_missing`] documentation has a beautiful example, unfortunately, the beef of the implementation is… missing. Left as exercise to the student, let's implement it!
By which I mean, search for "roman numerals to int" and copy the [first result](https://iq.opengenus.org/roman-to-integer/).
You'll notice that the example is C++, but after today, that's nothing that'll stop us!

```ruby=
def roman_to_int(str)
  result = n = 0
  str.reverse.each_char.map do |i|
    n = case i
      when 'i', 'I'
        1
      when 'x', 'X'
        10
      when 'v', 'V'
        5
      when 'l', 'L'
        50
      when 'c', 'C'
        100
      when 'd', 'D'
        500
      when 'm', 'M'
        1000
      end

    if (4 * n < result)
      result = result - n
    else
      result = result + n
    end
  end
  result
end
```

or, if you think that we should be using an iterator that already produces the correct result, namely a single integer, rather than returning an array like `map` which we then discard, we could use `reduce`:

```ruby
[31] pry(main)> edit roman_to_int
def roman_to_int(str)
  n = 0
  str.reverse.each_char.reduce(0) do |result, i|
    n = case i
      when 'i', 'I'
       …
      end

    if (4 * n < result)
      result = result - n
    else
      result = result + n
    end
  end
end
```

we can now plug this method into the `Roman` class and test it out for ourselves:

```ruby
[14] pry(main)> r.vi
=> 6
[15] pry(main)> r.emacs
NoMethodError: undefined method `emacs' for #<Roman:0x00007fdae884bc80>
from (pry):61:in `rescue in method_missing'
Caused by TypeError: nil can't be coerced into Integer
from (pry):48:in `*'
[16] pry(main)>
```

If you'd also like to give a slightly more meaningful Error message, an `else` to the `case` statement:

```ruby
    when 'm', 'M'
      1000
    else
      raise(RangeError, "Invalid Roman numeral '#{i}' in '#{str}'")
    end
```

but that still leaves us with a two level stack:

```ruby
[44] pry(main)> r.nvim
NoMethodError: undefined method `nvim' for #<Roman:0x000056388092cde0>
from pry-redefined(0x17c#method_missing):7:in `rescue in method_missing'
Caused by RangeError: Invalid Roman numeral 'n' in 'nvim'
from (pry):21:in `block in roman_to_int'
[45] pry(main)>
```

so what we can do instead is reject this earlier, namely in `method_missing`:

```ruby
def method_missing(symbol, *args)
  str = symbol.id2name
  raise(RangeError, "Invalid roman numerals in `#{str}'") unless str.chars.all?(%r{[ivxlcdm]}i)
  begin
    roman_to_int(str)
  rescue
    super(symbol, *args)
  end
end
```

```ruby
[49] pry(main)> r.nvim
RangeError: Invalid roman numerals in `nvim'
from pry-redefined(0x17c#method_missing):3:in `method_missing'
[50] pry(main)>
```

## That's all folks!

Next time We'll look into Puppet specific Ruby!
