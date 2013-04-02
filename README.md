from_spec.vim
=========

A very simple plugin to jump between your class file and your spec file
in a rails app.

* From your class file, type `:ToSpec`
* From your spec file, type `:FromSpec`
* Both `:ToSpec` and `:FromSpec` have split window version `:ToSpecsp`
and `:FromSpecsp` which will open the spec or class file in a new split
window.

Note, this currently makes is setup to for a Ruby on Rails project or a
mobile web project. 

* If you are using a Ruby on Rails project, your class files will be in
`app`  and your spec files will be in  `spec` folder.

* If you are using a Mobile web project, your class files will be in
`src/js` and your spec files `scr/spec`. Currently only handles .coffee
files.

We'll make this configurable in the future.

- [ ] Refactor Ruby method in corresponding_base.rb perhaps using a better
stategy to match the spec/class files.
- [ ] Make per project/directoy configurable, allow user to set src/spec
directory.
- [ ] Match files other than Ruby/CoffeeScript.
