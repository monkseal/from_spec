require 'minitest/spec'
require 'minitest/autorun'
require './corresponding_spec_file'

describe CorrespondingSpecFile do
  before do
    @class_file_path = 'app/models/authorization.rb'
  end

  it "returns itself" do
    CorrespondingSpecFile.new(@class_file_path).must_be_instance_of CorrespondingSpecFile
  end

  it "returns the file name" do
    cspec = CorrespondingSpecFile.new(@class_file_path)
    cspec.basename.must_equal 'authorization.rb'
  end

  it "returns the spec file name" do
    cspec = CorrespondingSpecFile.new(@class_file_path)
    cspec.spec_name.must_equal 'authorization_spec.rb'
  end

  it "returns the spec path name"
  # do
  #  cspec = CorrespondingSpecFile.new(@class_file_name)
  #  cspec.spec_path.must_equal 'spec/unit/models/authorization_spec.rb'
  # end

end
