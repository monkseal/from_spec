"  Maintainer:   Kevin English <http://monksealsoftware.com/>
"
"
if exists('g:loaded_from_spec') || &cp
  finish
endif
let g:loaded_from_spec = 1

if !has("ruby")
  echohl ErrorMsg
  echon "Sorry, FromSpec requires ruby support."
  :ruby print "Hello"
  finish
endif

function! ToSpec()
  :ruby to_spec
endfunction

function! ToSpecSp()
  :ruby to_spec_and_split
endfunction

function! FromSpec()
  :ruby from_spec
endfunction

function! FromSpecSp()
  :ruby from_spec_and_split
endfunction

:com -nargs=0 FromSpec call FromSpec()
:com -nargs=0 ToSpec call ToSpec()
:com -nargs=0 FromSpecsp call FromSpecSp()
:com -nargs=0 ToSpecsp call ToSpecSp()

ruby << EOF

vimscript_file = VIM::evaluate('expand("<sfile>")')
vimscript_dir  = File.dirname(vimscript_file)

require File.join(vimscript_dir,'corresponding_spec_file.rb')
require File.join(vimscript_dir,'corresponding_class_file.rb')

def current_file
  VIM::evaluate('@%')
end

def to_spec(split=false)
  cs = CorrespondingSpecFile.new(current_file)
  path = cs.spec_path
  if path
    cmd = split ? 'sp' : 'e'
    VIM::command("#{cmd} #{path}\"")
  else
    VIM::command("echo \"Spec not Found\"")
  end
end

def from_spec(split=false)
  cs = CorrespondingClassFile.new(current_file)
  path = cs.class_file_path
  if path
    cmd = split ? 'sp' : 'e'
    VIM::command("#{cmd} #{path}\"")
  else
    VIM::command("echo \"Class File not Found\"")
  end
end

def to_spec_and_split
  to_spec(true)
end

def from_spec_and_split
  from_spec(true)
end

EOF
