require 'spec_helper'
require "rake"
require "tcravit_ruby_lib/rake_tasks"
require "fantaskspec"

require "#{File.join(File.dirname(__FILE__), "support", "matchers", "version_bump_matchers.rb")}"

TEST_VERSION_FILE = "/tmp/bump_ver.out"

describe "version:bump:major", type: :rake do
  context "the basics" do 
    it "should be a rake task" do
      expect(subject).to be_a_rake_task_named("version:bump:major")
    end
  end

  context "file generation" do
    before(:each) do
      File.delete(TEST_VERSION_FILE) if File.exist?("/tmp/bump_ver.out")
    end

    it "should generate a file with the right format and module name" do
      args = to_task_arguments(1)
      task.execute(args)
      expect(TEST_VERSION_FILE).to be_a_valid_gem_version_file_for("TcravitRubyLib")
    end

    it "should increment the major version number" do
      initial_version = TcravitRubyLib::VERSION_DATA.clone
      args = to_task_arguments(1)
      task.execute(args)
      expect(TEST_VERSION_FILE).to declare_the_gem_version_to_be((initial_version[0] + 1), initial_version[1], initial_version[2])
    end
  end
end

describe "version:bump:minor", type: :rake do
  context "the basics" do 
    it "should be a rake task" do
      expect(subject).to be_a_rake_task_named("version:bump:minor")
    end
  end

  context "file generation" do
    before(:each) do
      File.delete(TEST_VERSION_FILE) if File.exist?("/tmp/bump_ver.out")
    end

    it "should generate a file with the right format and module name" do
      args = to_task_arguments(1)
      task.execute(args)
      expect(TEST_VERSION_FILE).to be_a_valid_gem_version_file_for("TcravitRubyLib")
    end

    it "should increment the minor version number" do
      initial_version = TcravitRubyLib::VERSION_DATA.clone
      args = to_task_arguments(1)
      task.execute(args)
      expect(TEST_VERSION_FILE).to declare_the_gem_version_to_be(initial_version[0], (initial_version[1] + 1), initial_version[2])
    end
  end
end

describe "version:bump:build", type: :rake do
  context "the basics" do 
    it "should be a rake task" do
      expect(subject).to be_a_rake_task_named("version:bump:build")
    end
  end

  context "file generation" do
    before(:each) do
      File.delete(TEST_VERSION_FILE) if File.exist?("/tmp/bump_ver.out")
    end

    it "should generate a file with the right format and module name" do
      args = to_task_arguments(1)
      task.execute(args)
      expect(TEST_VERSION_FILE).to be_a_valid_gem_version_file_for("TcravitRubyLib")
    end

    it "should increment build version number" do
      initial_version = TcravitRubyLib::VERSION_DATA.clone
      args = to_task_arguments(1)
      task.execute(args)
      expect(TEST_VERSION_FILE).to declare_the_gem_version_to_be(initial_version[0], initial_version[1], (initial_version[2] + 1))
    end
  end
end

describe "version:bump:set", type: :rake do
  context "the basics" do 
    it "should be a rake task" do
      expect(subject).to be_a_rake_task_named("version:bump:set")
    end
  end

  context "file generation" do
    before(:each) do
      File.delete(TEST_VERSION_FILE) if File.exist?("/tmp/bump_ver.out")
    end

    it "should generate a file with the right format and module name" do
      args = to_task_arguments(3,4,5,11)
      task.execute(args)
      expect(TEST_VERSION_FILE).to be_a_valid_gem_version_file_for("TcravitRubyLib")
    end

    it "should generate a file with the right version number" do
      args = to_task_arguments(3,4,5,1)
      task.execute(args)
      expect(TEST_VERSION_FILE).to declare_the_gem_version_to_be(3, 4, 5)
    end
  end
end

