# Repository Grader

Grader for evaluating Git repositories.
It uses prediction scores assigned by GitHub Classroom to the repositories,
adding similarity checks using [Dolos][dolos], as well as
commit pattern evaluations using [commit-grader][commit-grader].

We assume that auto-graders on GitHub Classroom have been set up, and
the scores can be downloaded via GitHub CLI. The repositories have
been evaluated individually.

Similarity checks require all the repositories across students, so this
step must be done separately here.


## Repository Setup

Clone this repository and its submodules.
```
git clone --recursive git@github.com:djhshih/repo-grader
```

Edit the environmental variables in `env.sh`.

Edit the scripts to evaluate in `scripts.vtr`.

Edit weights in integrate.R.

Install [Dolos][dolos] and [Github CLI][gh].

[dolos]: https://dolos.ugent.be/
[commit-grader]: https://github.com/djhshih/commit-grader
[gh]: https://cli.github.com/


## Workflow

Define environmental variables
```
. env.sh
```

Setup GitHub CLI and the repositories
```
./setup.sh
```

Run the grader
```
./run.sh
```

The results are output to `grades.tsv`.

