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
