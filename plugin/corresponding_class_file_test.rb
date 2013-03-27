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
    subject = CorrespondingClassFile.new(@spec_file_path)
    subject.basename.must_equal 'authorization_spec.rb'
  end

  it 'returns the class file name' do
    subject = CorrespondingClassFile.new(@spec_file_path)
    subject.class_file_name.must_equal 'authorization.rb'
  end

  describe 'for rails app' do
    before do
      @spec_file_path = 'spec/unit/models/authorization_spec.rb'
    end

    it 'only one spec corresponding spec' do
      FakeFS.activate!
      FileUtils.mkdir_p('app/models/authorization.rb')
      FileUtils.touch('app/models/authorization.rb')

      subject = CorrespondingClassFile.new(@spec_file_path)
      subject.class_file_path.must_equal 'app/models/authorization.rb'
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

      subject = CorrespondingClassFile.new(@spec_file_path)
      subject.class_file_path.must_equal 'app/models/authorization.rb'
      FakeFS.deactivate!
    end

    it 'rare case that spec does not correspond to a class in our directories' do
      FakeFS.activate!
      FileUtils.mkdir_p('app/lib')
      FileUtils.mkdir_p('app/controller')
      FileUtils.touch('app/lib/authorization.rb')
      FileUtils.touch('app/controller/authorization.rb')
      spec_file_path = 'path/to/authorization_spec.rb'
      subject = CorrespondingClassFile.new(spec_file_path)
      subject.class_file_path.must_be_nil
      FakeFS.deactivate!
    end
  end

  describe 'for mobile app' do
    before do
      @spec_file_path = 'src/spec/monkseal/models/user.spec.coffee'
    end

    it "only one coffee class corresponding to spec" do
      FakeFS.activate!
      FileUtils.mkdir_p 'src/js/monkseal/models'
      FileUtils.touch   'src/js/monkseal/models/user.coffee'
      subject = CorrespondingClassFile.new(@spec_file_path)
      subject.class_file_path.must_equal 'src/js/monkseal/models/user.coffee'
      FakeFS.deactivate!
    end

    it 'many files with same name returns best match based on directory' do
      FakeFS.activate!
      FileUtils.mkdir_p 'src/js/monkseal/models'
      FileUtils.mkdir_p 'src/js/monkseal/presenters'
      FileUtils.touch   'src/js/monkseal/models/user.coffee'
      FileUtils.touch   'src/js/monkseal/presenters/user.coffee'
      subject = CorrespondingClassFile.new(@spec_file_path)
      subject.class_file_path.must_equal 'src/js/monkseal/models/user.coffee'
      FakeFS.deactivate!
    end
  end
end
