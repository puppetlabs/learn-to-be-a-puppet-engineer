# Defined Types

## Documentation

<https://puppet.com/docs/puppet/latest/lang_defined_types.html>

## Education

Not covered in GSWP.

Covered in Practitioner, including a lab.

## Other

Nothing else that I know of.
People often struggle with this quite a lot and it would be really good to find a good way of teaching this.
I think the most important concept is the fact that classes are used to model things that are inherently singleton and defined types are better for things that there can be more than one of.
But many people struggle to combine these concepts, especially within a single module.
Some good examples are things like tomcat, where you can have many instances and therefore it's a defined type.
Or some kind of database software where you only install the database software once but then you can create many database on top of that so it could be a defined type.

These are also under-utilised in profiles.
They are a very good way of creating interfaces that allow a stable API for hiera data.
For example if you were to create a `mycompany::localuser` type and pull some relevant company-specific data from hiera,
if you then later wanted to change say the default `homedir` or something,
you could edit the defined type without having to change all of the hiera data.
