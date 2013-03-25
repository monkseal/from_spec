require 'minitest/spec'
require 'minitest/autorun'
require './corresponding_class_file'
require 'fakefs/safe'

describe CorrespondingClassFile do
  before do
    @spec_file_path = 'spec/unit/models/authorization_spec.rb'
  end

  it 'returns itself' do
    CorrespondingClassFile.new(@spec_file_path).must_be_instance_of CorrespondingClassFile
  end

  it 'returns the file name' do
    cclass = CorrespondingClassFile.new(@spec_file_path)
    cclass.basename.must_equal 'authorization_spec.rb'
  end

  it 'returns the class file name' do
    cclass = CorrespondingClassFile.new(@spec_file_path)
    cclass.class_file_name.must_equal 'authorization.rb'
  end

  describe 'with fakefs' do
    before do
      @spec_file_path = 'spec/unit/models/authorization_spec.rb'
    end

    it 'only one spec corresponding spec' do
      FakeFS.activate!
      FileUtils.mkdir_p('app/models/authorization.rb')
      FileUtils.touch('app/models/authorization.rb')

      cclass = CorrespondingClassFile.new(@spec_file_path)
      cclass.class_file_path.must_equal 'app/models/authorization.rb'
      FakeFS.deactivate!
    end

    it 'many files with same name returns best match based on directory' do
      FakeFS.activate!
      FileUtils.mkdir_p('app/models')
      FileUtils.mkdir_p('app/lib')
      FileUtils.mkdir_p('app/controller')
      FileUtils.touch('app/models/authorization.rb')
      FileUtils.touch('app/lib/authorization.rb')
      FileUtils.touch('app/controller/authorization.rb')

      cclass = CorrespondingClassFile.new(@spec_file_path)
      cclass.class_file_path.must_equal 'app/models/authorization.rb'
      FakeFS.deactivate!
    end

    it 'rare case that spec does not correspond to a class in our directories' do
      FakeFS.activate!
      FileUtils.mkdir_p('app/lib')
      FileUtils.mkdir_p('app/controller')
      FileUtils.touch('app/lib/authorization.rb')
      FileUtils.touch('app/controller/authorization.rb')
      spec_file_path = 'path/to/authorization_spec.rb'
      cclass = CorrespondingClassFile.new(spec_file_path)
      cclass.class_file_path.must_be_nil
      FakeFS.deactivate!
    end
  end
end
