require File.join(File.dirname(__FILE__), 'corresponding_base')

class CorrespondingSpecFile < CorrespondingBase

  def spec_path
    matches = Dir.glob(dir_expression).select do|f|
      f.match(/\/#{spec_name}$/)
    end
    handle_matches(matches)
  end

  def spec_name
    return @spec_name unless @spec_name.nil?
    @rspec_name =
      if file.end_with?('.coffee')
        basename.sub(/\.coffee/, '.spec.coffee')
      else
        basename.sub(/\.rb/, '_spec.rb')
      end
  end

  def dir_expression
    if file.end_with?('.coffee')
      'src/spec/**/*.spec.coffee'
    else
      'spec/**/*_spec.rb'
    end
  end
end
