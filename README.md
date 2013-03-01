from_spec.vim
=========

A very simple plugin to jump between your class file and your spec file
in a rails app.

* From your class file, type `:ToSpec`
* From your spec file, type `:FromSpec`

Note, this currently makes assumptions about your Rails app, namely,
that all your unit tests are under `/spec/unit`. We'll make this
configurable in the future.
