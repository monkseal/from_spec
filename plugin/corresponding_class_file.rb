require File.join(File.dirname(__FILE__), 'corresponding_base')

class CorrespondingClassFile < CorrespondingBase

  def class_file_name
    basename.sub(/_spec\.rb/, '.rb')
  end

  def class_file_path
    matches = Dir.glob('app/**/*.rb').select do|f|
      f.match(/\/#{class_file_name}$/)
    end

    #    matches = Dir.glob('spec/**/*_spec.rb').select do|f|
    #      f.match(/\/#{spec_name}$/)
    #    end
    handle_matches(matches)
  end
end
