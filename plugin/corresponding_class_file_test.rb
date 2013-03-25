require 'minitest/spec'
require 'minitest/autorun'
require './corresponding_class_file'


describe CorrespondingClassFile do
  before do
    @spec_file_path = 'spec/unit/models/authorization_spec.rb'
  end

  it "returns itself" do
    CorrespondingClassFile.new(@spec_file_path).must_be_instance_of CorrespondingClassFile
  end

  it "returns the file name" do
    cclass = CorrespondingClassFile.new(@spec_file_path)
    cclass.basename.must_equal 'authorization_spec.rb'
  end

  it "returns the class file name" do
    cclass = CorrespondingClassFile.new(@spec_file_path)
    cclass.class_file_name.must_equal 'authorization.rb'
  end

  it "returns the spec path name" # do
#    cclass = CorrespondingClassFile.new(@spec_file_path)
#    cclass.class_file_path.must_equal 'app/models/authorization.rb'
  #end

end
