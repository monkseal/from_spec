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

function! FromSpec()
  :ruby from_spec
endfunction

:com -nargs=0 FromSpec call FromSpec()
:com -nargs=0 ToSpec call ToSpec()

ruby << EOF

require '/Users/kenglish/.janus/from_spec/plugin/corresponding_spec_file.rb'
require '/Users/kenglish/.janus/from_spec/plugin/corresponding_class_file.rb'

def current_file
  VIM::evaluate('@%')
end

def to_spec
  cs = CorrespondingSpecFile.new(current_file)
  path = cs.spec_path
  if path
    VIM::command("e #{path}\"")
  else
    VIM::command("echo \"Spec not Found\"")
  end
end

def from_spec
  cs = CorrespondingClassFile.new(current_file)
  path = cs.class_file_path
  if path
    VIM::command("e #{path}\"")
  else
    VIM::command("echo \"Class File not Found\"")
  end
end

EOF
