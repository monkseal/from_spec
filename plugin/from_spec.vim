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

class CorrespondingSpecFile
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def basename
    File.basename(file)
  end

  def spec_name
    basename.sub(/\.rb/, '_spec.rb')
  end

  def spec_path
    Dir.glob('spec/unit/**/*_spec.rb').detect do|f|
      f.match(/\/#{spec_name}$/)
    end
  end
end

class CorrespondingClassFile
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def basename
    File.basename(file)
  end

  def class_file_name
    basename.sub(/_spec\.rb/, '.rb')
  end

  def class_file_path
    Dir.glob('app/**/*.rb').detect do|f|
      f.match(/\/#{class_file_name}$/)
    end
  end
end


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
