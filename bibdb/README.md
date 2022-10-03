BibTeX Reference Database for Systems, Networking, and Architecture
===================================================================
**Author:** Antoine Kaufmann <antoinek@mpi-sws.org>

This is a (non-authoritative) collection of relatively uniform BibTeX
entries for papers in systems, networking, and computer architecture. I include
this fully in my papers and documents, and incremetally add references as I need
them. Here in this repo is the most up-to-date version, that I regularly copy to
paper repos as I am working on them and add references as I need them.

*If you are working on a paper with me, please do not modify these files in the
paper repo directly, otherwise the next time I copy in the most recent version
of the database your changes will be lost*. Either add entries to the
paper-repo-local `paper.bib` (these can still crossref entries from this
database), or fork this repo make the changes there and immediately submit a PR.

When submitting PRs for this repo please make sure to respect the formatting
conventions. Entries in `papers.bib` are grouped by conference/journal with
comments separating them. Next for each conference/journal entries are grouped
by year with blank spaces separating years. Within each group entries are sorted
alphabetically by key. For the keys, the database uses
`FIRST_AUTHOR_LASTNAME:SYSTEMNAME`. When there is no system name in the paper,
choose some short keyword that makes sense for the paper. For the actual
entries, crossref for the journal or conference always comes first, then author,
then title. In titles carefully escape terms that must be capitalized properly
(e.g. system acronyms or product names e.g. `{RPCs}` or `{Ethernet}`).

Lastly, I only add entries that I anticipate re-using. Conference and major
journal publications are clear cases, good workshops too. Random white
papers/blog posts/etc. only go in here in exceptional cases. Things that will
not be needed for other papers, or that are not expected to be stable, belong
in the paper-local `paper.bib`.
