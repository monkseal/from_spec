require File.join(File.dirname(__FILE__), 'corresponding_base')

class CorrespondingSpecFile < CorrespondingBase
  def spec_name
    basename.sub(/\.rb/, '_spec.rb')
  end

  def spec_path
    matches = Dir.glob('spec/**/*_spec.rb').select do|f|
      f.match(/\/#{spec_name}$/)
    end
    handle_matches(matches)
  end

end
