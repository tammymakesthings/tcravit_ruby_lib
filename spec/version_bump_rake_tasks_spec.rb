require 'spec_helper'
require "rake"
require "tcravit_ruby_lib/rake_tasks"
require "fantaskspec"

def read_output_file(f)
  lines = []

  if File.exist?(f)
    fh = open(f)
    fh.each { |l| lines.push(l.chomp) }
    fh.close
  end
  return lines
end

describe "version:bump:major", type: :rake do
  context "the basics" do 
    it "should be a rake task" do
      expect(subject).to be_a(Rake::Task)
      expect(subject.name).to be == "version:bump:major"
    end
  end

  context "file generation" do
    before(:each) do
      File.delete("/tmp/bump_ver.out") if File.exist?("/tmp/bump_ver.out")
    end

    it "should generate a file with the right format and module name" do
      args = to_task_arguments(1)
      task.execute(args)
      expect(File.exist?("/tmp/bump_ver.out")).to be == true
      contents = read_output_file("/tmp/bump_ver.out")
      expect(contents[0]).to be == "module TcravitRubyLib"
      expect(contents[1]).to match(/^\s+VERSION_DATA = \[\d+, \d+, \d+\]\s*$/)
      expect(contents[3]).to be == "end"
    end

    it "should increment the major version number" do
      initial_version = TcravitRubyLib::VERSION_DATA.clone
      args = to_task_arguments(1)
      task.execute(args)
      expect(File.exist?("/tmp/bump_ver.out")).to be == true
      contents = read_output_file("/tmp/bump_ver.out")
      v = eval(contents[1].downcase)
      expect(v[0]).to be == (initial_version[0] + 1)
      expect(v[1]).to be == initial_version[1]
      expect(v[2]).to be == initial_version[2]
    end
  end
end

describe "version:bump:minor", type: :rake do
  context "the basics" do 
    it "should be a rake task" do
      expect(subject).to be_a(Rake::Task)
      expect(subject.name).to be == "version:bump:minor"
    end
  end

  context "file generation" do
    before(:each) do
      File.delete("/tmp/bump_ver.out") if File.exist?("/tmp/bump_ver.out")
    end

    it "should generate a file with the right format and module name" do
      args = to_task_arguments(1)
      task.execute(args)
      expect(File.exist?("/tmp/bump_ver.out")).to be == true
      contents = read_output_file("/tmp/bump_ver.out")
      expect(contents[0]).to be == "module TcravitRubyLib"
      expect(contents[1]).to match(/^\s+VERSION_DATA = \[\d+, \d+, \d+\]\s*$/)
      expect(contents[3]).to be == "end"
    end

    it "should increment the minor version number" do
      initial_version = TcravitRubyLib::VERSION_DATA.clone
      args = to_task_arguments(1)
      task.execute(args)
      expect(File.exist?("/tmp/bump_ver.out")).to be == true
      contents = read_output_file("/tmp/bump_ver.out")
      v = eval(contents[1].downcase)
      expect(v[0]).to be == initial_version[0]
      expect(v[1]).to be == (initial_version[1] + 1)
      expect(v[2]).to be == initial_version[2]
    end
  end
end

describe "version:bump:build", type: :rake do
  context "the basics" do 
    it "should be a rake task" do
      expect(subject).to be_a(Rake::Task)
      expect(subject.name).to be == "version:bump:build"
    end
  end

  context "file generation" do
    before(:each) do
      File.delete("/tmp/bump_ver.out") if File.exist?("/tmp/bump_ver.out")
    end

    it "should generate a file with the right format and module name" do
      args = to_task_arguments(1)
      task.execute(args)
      expect(File.exist?("/tmp/bump_ver.out")).to be == true
      contents = read_output_file("/tmp/bump_ver.out")
      expect(contents[0]).to be == "module TcravitRubyLib"
      expect(contents[1]).to match(/^\s+VERSION_DATA = \[\d+, \d+, \d+\]\s*$/)
      expect(contents[3]).to be == "end"
    end

    it "should increment build version number" do
      initial_version = TcravitRubyLib::VERSION_DATA.clone
      args = to_task_arguments(1)
      task.execute(args)
      expect(File.exist?("/tmp/bump_ver.out")).to be == true
      contents = read_output_file("/tmp/bump_ver.out")
      v = eval(contents[1].downcase)
      expect(v[0]).to be == initial_version[0]
      expect(v[1]).to be == initial_version[1]
      expect(v[2]).to be == (initial_version[2] + 1)
    end
  end
end

describe "version:bump:set", type: :rake do
  context "the basics" do 
    it "should be a rake task" do
      expect(subject).to be_a(Rake::Task)
      expect(subject.name).to be == "version:bump:set"
    end
  end

  context "file generation" do
    before(:each) do
      File.delete("/tmp/bump_ver.out") if File.exist?("/tmp/bump_ver.out")
    end

    it "should generate a file with the right format and module name" do
      args = to_task_arguments(3,4,5,11)
      task.execute(args)
      expect(File.exist?("/tmp/bump_ver.out")).to be == true
      contents = read_output_file("/tmp/bump_ver.out")
      expect(contents[0]).to be == "module TcravitRubyLib"
      expect(contents[1]).to match(/^\s+VERSION_DATA = \[\d+, \d+, \d+\]\s*$/)
      expect(contents[3]).to be == "end"
    end

    it "should generate a file with the right version number" do
      args = to_task_arguments(3,4,5,1)
      task.execute(args)
      expect(File.exist?("/tmp/bump_ver.out")).to be == true
      contents = read_output_file("/tmp/bump_ver.out")
      v = eval(contents[1].downcase)
      expect(v[0]).to be == 3
      expect(v[1]).to be == 4
      expect(v[2]).to be == 5
    end
  end
end

