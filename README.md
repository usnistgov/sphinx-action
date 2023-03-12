# Sphinx Build Action

[![Build Status](https://travis-ci.org/usnistgov/sphinx-action.svg?branch=latexpdf)](https://travis-ci.org/usnistgov/sphinx-action)
[![Test Coverage](https://codecov.io/gh/usnistgov/sphinx-action/branch/latexpdf/graph/badge.svg)](https://codecov.io/gh/usnistgov/sphinx-action)


This is a Github action that looks for Sphinx documentation folders in your
project. It builds the documentation using Sphinx and any errors in the build
process are bubbled up as Github status checks.

This action differs from `usnistgov/sphinx-action@master` in that the Docker
image is based on `sphinxdoc/sphinx-latexpdf`, which is considerably larger
(over 2 GB). If you will be building both LaTeX and HTML or ePUB variants, this
action can be used for all. If LaTeX is not desired,
`usnistgov/sphinx-action@master` is recommended.

The main purposes of this action are:

* Run a CI test to ensure your documentation still builds. 

* Allow contributors to get build errors on simple doc changes inline on Github
  without having to install Sphinx and build locally.
  
![Example Screenshot](https://i.imgur.com/Gk2W32O.png)

## How to use

Create a workflow for the action, for example:

```yaml
name: "Pull Request Docs Check"
on: 
- pull_request

jobs:
  docs:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: usnistgov/sphinx-action@latexpdf
      with:
        docs-folder: "docs/"
```

* If you have any Python dependencies that your project needs (themes, 
build tools, etc) then place them in a requirements.txt file inside your docs
folder.

* If you have multiple sphinx documentation folders, please use multiple
  `uses` blocks.

For a full example repo using this action including advanced usage, take a look
at https://github.com/ammaraskar/sphinx-action-test

## Great Actions to Pair With

Some really good actions that work well with this one are
[`actions/upload-artifact`](https://github.com/actions/upload-artifact)
and [`ad-m/github-push-action`](https://github.com/ad-m/github-push-action).

You can use these to make built HTML and PDFs available as artifacts:

```yaml
    - uses: actions/upload-artifact@v1
      with:
        name: DocumentationHTML
        path: docs/_build/html/
```

Or to push docs changes automatically to a `nist-pages` branch:

```yaml
    - uses: usnistgov/NISTtheDocs2Death@main
      with:
        docs-folder: docs/
```

For a full fledged example of an older version of this in action take a look at:
https://github.com/ammaraskar/sphinx-action-test

## Advanced Usage

If you wish to customize the command used to build the docs (defaults to
`make html`), you can provide a `build-command` in the `with` block. For
example, to invoke sphinx-build directly you can use:

```yaml
    - uses: usnistgov/sphinx-action@latexpdf
      with:
        docs-folder: "docs/"
        build-command: "sphinx-build -b latex . _build"
```

If there's system level dependencies that need to be installed for your
build, you can use the `pre-build-command` argument like so:

```yaml
    - uses: usnistgov/sphinx-action@latexpdf
      with:
        docs-folder: "docs2/"
        pre-build-command: "apt-get update -y && apt-get install -y latexmk texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended"
        build-command: "make latexpdf"
```

## Running the tests

`python -m unittest`

## Formatting

Please use [black](https://github.com/psf/black) for formatting:

`black entrypoint.py sphinx_action tests`
