keg-recipes
===========

This repository contains recipes that can be used to generate
various [kiwi](https://github.com/OSInside/kiwi) image descriptions using
[keg](https://github.com/SUSE-Enceladus/keg).

The "released" branch reflects the image descriptions as they are used to
build images maintained and published by SUSE. Details about how changes are
applied are provided in CONTRIBUTING.md

Basics
======

Keg recipes contain three types of input data, the image recipe in the `images`
sub directory, the image data in the `data` sub directory, and the schema
definition in the `schemas` sub directory. The recipe and data configuration is
in YAML format, the schemas are Jinja2 templates.

The schema defines the structure of the output, namely the kiwi configuration
file and setup script. The configuration data used by the schema is collected
by keg from the image recipe and the data bits referenced by the recipe.

Keg merges the input data in a way that allows to mix and match configuration
bits to create a specific image description. This can be used to create a large
number of different image descriptions based on the input configuration without
the need to edit them directly.

Structure
=========

Image recipes
-------------

A recipe defines the image's base parameters and one or more build profiles. Any
leaf directory under `image` acts as the input parameter for keg. Keg will
read any YAML file in that directory and merge it with all YAML files of its
parent directories. This allows to e.g. define global defaults in the top level
directory, product specific defaults in a directory below that, and all bits
unique to the image in the leaf directories.

Image data
----------

The `data` sub directory contains sets of parameters that form logical blocks
of configuration data. The `base` sub directory contains blocks for building
the OS base of the image. The `csp` sub directory contains blocks for adding
support for a specific cloud framework. The `products` sub directory contains
blocks for building a product on top of the OS base, e.g. SUSE Manager.

The data files get merged in a similar way as the image recipe files, but keg
may scan additional sub directories based on the `include-suffix` parameter of
the image recipe, and this applies to all parent directories as well. This can
be used to add OS version specific changes to the generic configuration.

To visualize how this works in practice, let's look at the configuration sets
for EC2 support. A recipe for a SLES 15 SP2 EC2 image may contain the following
configuration parameters:

```
include-prefix: sle15/sp2
profile:
  EC2-HVM:
    include:
      - csp/ec2/ondemand
```

This will result in keg scanning the following directories for input files:

```
data/csp/ec2/ondemand/sle15/sp2
data/csp/ec2/ondemand/sle15
data/csp/ec2/ondemand
data/csp/ec2/sle15/sp2
data/csp/ec2/sle15
data/csp/ec2
data/csp/sle15/sp2
data/csp/sle15
data/csp
data/sle15/sp2
data/sle15
data
```

This may pick up the following files:

```
data/csp/profile_defaults.yaml
data/csp/ec2/profile.yaml
data/csp/ec2/sle15/packages.yaml
data/csp/ec2/ondemand/sle15/packages.yaml
```

And thus use the global profile defaults for all CSPs, the EC2 specific
default profile, the SLES 15 set of EC2 specific packages, and the additional
SLES 15 packages required for on-demand functionality.
