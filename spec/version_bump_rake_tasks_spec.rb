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
			subject.should be_a(Rake::Task)
			subject.name.should == "version:bump:major"
		end
	end

	context "file generation" do
		before(:each) do
			File.delete("/tmp/bump_ver.out") if File.exist?("/tmp/bump_ver.out")
		end

		it "should generate a file with the right format" do
			args = to_task_arguments(1)
			task.execute(args)
			File.exist?("/tmp/bump_ver.out").should == true
			contents = read_output_file("/tmp/bump_ver.out")
			contents[0].should == "module TcravitRubyLib"
			contents[1].should match(/^\s+VERSION_DATA = \[\d+, \d+, \d+\]\s*$/)
			contents[3].should == "end"
		end

		it "should increment the major version number" do
			initial_version = TcravitRubyLib::VERSION_DATA.clone
			args = to_task_arguments(1)
			task.execute(args)
			File.exist?("/tmp/bump_ver.out").should == true
			contents = read_output_file("/tmp/bump_ver.out")
			v = eval(contents[1].downcase)
			v[0].should == (initial_version[0] + 1)
			v[1].should == initial_version[1]
			v[2].should == initial_version[2]
		end
	end
end

describe "version:bump:minor", type: :rake do
	context "the basics" do 
		it "should be a rake task" do
			subject.should be_a(Rake::Task)
			subject.name.should == "version:bump:minor"
		end
	end

	context "file generation" do
		before(:each) do
			File.delete("/tmp/bump_ver.out") if File.exist?("/tmp/bump_ver.out")
		end

		it "should generate a file with the right format" do
			args = to_task_arguments(1)
			task.execute(args)
			File.exist?("/tmp/bump_ver.out").should == true
			contents = read_output_file("/tmp/bump_ver.out")
			contents[0].should == "module TcravitRubyLib"
			contents[1].should match(/^\s+VERSION_DATA = \[\d+, \d+, \d+\]\s*$/)
			contents[3].should == "end"
		end

		it "should increment the minor version number" do
			initial_version = TcravitRubyLib::VERSION_DATA.clone
			args = to_task_arguments(1)
			task.execute(args)
			File.exist?("/tmp/bump_ver.out").should == true
			contents = read_output_file("/tmp/bump_ver.out")
			v = eval(contents[1].downcase)
			v[0].should == initial_version[0]
			v[1].should == (initial_version[1] + 1)
			v[2].should == initial_version[2]
		end
	end
end

describe "version:bump:build", type: :rake do
	context "the basics" do 
		it "should be a rake task" do
			subject.should be_a(Rake::Task)
			subject.name.should == "version:bump:build"
		end
	end

	context "file generation" do
		before(:each) do
			File.delete("/tmp/bump_ver.out") if File.exist?("/tmp/bump_ver.out")
		end

		it "should generate a file with the right format" do
			args = to_task_arguments(1)
			task.execute(args)
			File.exist?("/tmp/bump_ver.out").should == true
			contents = read_output_file("/tmp/bump_ver.out")
			contents[0].should == "module TcravitRubyLib"
			contents[1].should match(/^\s+VERSION_DATA = \[\d+, \d+, \d+\]\s*$/)
			contents[3].should == "end"
		end

		it "should increment build version number" do
			initial_version = TcravitRubyLib::VERSION_DATA.clone
			args = to_task_arguments(1)
			task.execute(args)
			File.exist?("/tmp/bump_ver.out").should == true
			contents = read_output_file("/tmp/bump_ver.out")
			v = eval(contents[1].downcase)
			v[0].should == initial_version[0]
			v[1].should == initial_version[1]
			v[2].should == (initial_version[2] + 1)
		end
	end
end

describe "version:bump:set", type: :rake do
	context "the basics" do 
		it "should be a rake task" do
			subject.should be_a(Rake::Task)
			subject.name.should == "version:bump:set"
		end
	end

	context "file generation" do
		before(:each) do
			File.delete("/tmp/bump_ver.out") if File.exist?("/tmp/bump_ver.out")
		end

		it "should generate a file with the right format" do
			args = to_task_arguments(3,4,5,11)
			task.execute(args)
			File.exist?("/tmp/bump_ver.out").should == true
			contents = read_output_file("/tmp/bump_ver.out")
			contents[0].should == "module TcravitRubyLib"
			contents[1].should match(/^\s+VERSION_DATA = \[\d+, \d+, \d+\]\s*$/)
			contents[3].should == "end"
		end

		it "should generate a file with the right version number" do
			args = to_task_arguments(3,4,5,1)
			task.execute(args)
			File.exist?("/tmp/bump_ver.out").should == true
			contents = read_output_file("/tmp/bump_ver.out")
			v = eval(contents[1].downcase)
			v[0].should == 3
			v[1].should == 4
			v[2].should == 5
		end
	end
end

