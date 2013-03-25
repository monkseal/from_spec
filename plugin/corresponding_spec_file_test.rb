require 'minitest/spec'
require 'minitest/autorun'
require './corresponding_spec_file'
require "fakefs/safe"

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

  describe 'with fakefs' do
    before do
      @class_file_path = 'app/models/authorization.rb'
    end

    it "only one spec corresponding spec" do
      FakeFS.activate!
      FileUtils.mkdir_p("spec/unit/models")
      FileUtils.touch("spec/unit/models/authorization_spec.rb")
      cspec = CorrespondingSpecFile.new(@class_file_path)
      cspec.spec_path.must_equal 'spec/unit/models/authorization_spec.rb'
      FakeFS.deactivate!
    end

    it "returns the spec path name closest to the directory of the class file" do
      FakeFS.activate!
      FileUtils.mkdir_p("spec/unit/models")
      FileUtils.mkdir_p("spec/unit/libs")
      FileUtils.touch("spec/unit/models/authorization_spec.rb")
      FileUtils.touch("spec/unit/libs/authorization_spec.rb")

      cspec = CorrespondingSpecFile.new(@class_file_path)
      cspec.spec_path.must_equal 'spec/unit/models/authorization_spec.rb'
      FakeFS.deactivate!
    end
    it 'should return nil when no match (but only for more than one)' do
      FakeFS.activate!
      FileUtils.mkdir_p("spec/unit/models")
      FileUtils.mkdir_p("spec/unit/controller/admin")
      FileUtils.mkdir_p("spec/unit/libs")
      FileUtils.touch("spec/unit/models/authorization_spec.rb")
      FileUtils.touch("spec/unit/libs/authorization_spec.rb")
      class_file_path = 'app/controller/admin/authorization.rb'
      cspec = CorrespondingSpecFile.new(class_file_path)
      cspec.spec_path.must_be_nil
      FakeFS.deactivate!

    end

  end

end
