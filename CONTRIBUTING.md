keg-recipes contributions
=========================

We work with two branches, the "released" branch and the "develop" branch.
The "released" branch represents the state of the descriptions as used for
the creation of production, i.e. released images. Meaning when using
[keg](https://github.com/SUSE-Enceladus/keg) against the "released" branch one
can generate the exact description used by SUSE to create images in the
[Open Build Service](https://openbuildservice.org/) that are published as
production images. The "develop" branch represents the image descriptions that
are in a development state or changes in flight to the "released" branch.

Changes enter the "released" branch either as wholesale merge or as
cherry picks from the "develop" branch. PRs submitted directly to "released"
branch that do not originate from the "develop" branch will not be accepted.
