require File.join(File.dirname(__FILE__), 'corresponding_base')

class CorrespondingClassFile < CorrespondingBase

  def class_file_path
    matches = Dir.glob(dir_expression).select do|f|
      f.match(/\/#{class_file_name}$/)
    end
    handle_matches(matches)
  end

  def class_file_name
    return @class_file_name unless @class_file_name.nil?
    @class_file_name =
      if file.end_with?('.coffee')
        basename.sub('.spec.coffee', '.coffee')
      else
        basename.sub('_spec.rb', '.rb')
      end
  end

  def dir_expression
    if file.end_with?('.coffee')
      'src/**/*.coffee'
    else
      'app/**/*.rb'
    end
  end

end
