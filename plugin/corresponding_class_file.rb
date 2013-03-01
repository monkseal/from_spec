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
