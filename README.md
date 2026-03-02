# Repository Grader

Grader (offline) for evaluating Git repositories.
It uses grades assigned by GitHub Classroom to the repositories,
adding similarity checks using [Dolos][dolos], as well as
commit pattern evaluations using [commit-grader][commit-grader].

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

