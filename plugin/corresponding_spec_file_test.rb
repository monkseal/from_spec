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
    subject = CorrespondingSpecFile.new(@class_file_path)
    subject.basename.must_equal 'authorization.rb'
  end

  it "returns the spec file name" do
    subject = CorrespondingSpecFile.new(@class_file_path)
    subject.spec_name.must_equal 'authorization_spec.rb'
  end

  describe 'for rails app' do
    before do
      @class_file_path = 'app/models/authorization.rb'
    end

    it "only one spec corresponding spec" do
      FakeFS.activate!
      FileUtils.mkdir_p("spec/unit/models")
      FileUtils.touch("spec/unit/models/authorization_spec.rb")
      subject = CorrespondingSpecFile.new(@class_file_path)
      subject.spec_path.must_equal 'spec/unit/models/authorization_spec.rb'
      FakeFS.deactivate!
    end

    it "returns the spec path name closest to the directory of the class file" do
      FakeFS.activate!
      FileUtils.mkdir_p("spec/unit/models")
      FileUtils.mkdir_p("spec/unit/libs")
      FileUtils.touch("spec/unit/models/authorization_spec.rb")
      FileUtils.touch("spec/unit/libs/authorization_spec.rb")

      subject = CorrespondingSpecFile.new(@class_file_path)
      subject.spec_path.must_equal 'spec/unit/models/authorization_spec.rb'
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
      subject = CorrespondingSpecFile.new(class_file_path)
      subject.spec_path.must_be_nil
      FakeFS.deactivate!
    end
  end

  describe 'for mobile app' do
    before do
      @class_file_path = 'src/js/monkseal/models/user.coffee'
    end

    it "only one coffee spec corresponding to class" do
      FakeFS.activate!
      FileUtils.mkdir_p('src/spec/monkseal/models')
      FileUtils.touch('src/spec/monkseal/models/user.spec.coffee')
      subject = CorrespondingSpecFile.new(@class_file_path)
      subject.spec_path.must_equal 'src/spec/monkseal/models/user.spec.coffee'
      FakeFS.deactivate!
    end
  end
end
