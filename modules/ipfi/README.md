- 🪶 edit/patch the repo's inputs without leaving its clone directory
- 🕺 no `--override-input` flag; less typing and avoids confusion in case omitted
- 🐬 single-repo setup; less to keep track of, more self-contained
- ⚡ provided scripts save time and produce consistency
- 😮‍💨 some mental and operational overhead such as an occasional `git submodule update`

IPFIs are stored in this very repository.
Yes, even though they are branches from disparate repositories,
they are stored in the repository in which they are used.
Git doesn't mind.

For each IPFI a git submodule exists.
That submodule is a clone of this very same repository.
The head of that submodule is set to the head of the IPFI branch.

Finally, each `inputs.<name>.url` value is a path to the corresponding IPFI submodule directory.

> [!WARNING]
> There seems to be an issue with Nix that affects the IPFI pattern.
> Workaround: artificially make the repository dirty.

Documentation: see the implementation and usage in this directory.

How to cherry pick for an IPFI:

1. `cd patched-inputs/<input>`
1. Get on the `patched-inputs/<input>` branch.
1. Add a remote for a fork and cherry-pick from it.
1. Make sure to push.
