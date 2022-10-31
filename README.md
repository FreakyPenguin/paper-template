# OS Group Paper Template

This is our suggested template for paper repositories. Most of this is not about
formatting as that will largely be dictated by conference specific instructions
anyways. Instead this includes the general scaffolding for building the paper,
figures, spell-checking, gitlab-CI etc. This is meant as a starting point for
papers, but we would expect some changes for every paper anyways.


## Build System

`make` or `make all` should build the paper and all the dependencies (figures,
etc). This should be the minimum that any derived paper repo should preserve.

In addition the Makefile contains a few other useful targets:

 * `make clean` will remove all generated files, including the paper pdf.
 * `make check` performs a spell check and general LaTeX sanity check using the
   [texidote](https://github.com/sylvainhalle/textidote) checker (this requires
   a working Java JRE on the system), reporting issues to the console.
 * `make check-html` instead outputs a neatly formatted HTML report for the
   check.
 * `make arxiv` generates a tarball for upload on arxiv. This strips out
   comments and concatenates all latex into a single file. The target will
   also include the bibtex generated bbl file as required. Often this target will
   need manual tweaking per project to ensure that all figures etc. are included
   in the tarball.
 * `make updatebib` will pull in the newest version of the bibliography database
   (see below).


## Bibliography Database

Antoine typically uses a [central reference
database](https://github.com/FreakyPenguin/bibliography) for bibtex. The main
goal is to reduce the effort for consistent and neat bibliographies. If you
prefer, you are free to not use this and instead just put references in the
`paper.bib` file.

If you do want to use the reference database have a look at
[`bibdb/README.md`](bibdb/README.md). In particular, make sure to never make
changes to the `.bib` files in `bibdb/` directly. `make updatebib` will pull in
the most recent version from github and running this should always be safe. So
if you have changes, make them in a fork and submit a PR to the github repo.
(okay to temporarily push the inconsistent `.bib` files while the PR is
pending). As the bibliography database is used across many repos, having locally
diverging versions is a recipe for disaster.

Note that even when using the database you can always add entries to the local
`paper.bib` file as well. And Antoine only adds entries to the database if they
are likely to be re-used in the future.


## CI

The template also includes th `.gitlab-ci.yml` config file to automatically
build the paper using gitlab's CI for every push and also run the spell checker.
The CI interface on gitlab will include the paper PDF and spellcheck report as
artifacts that can be downloaded. Note that the CI job will not fail due to
errors reported by the spell checker.
