require 'rspec/expectations'

module TcravitRubyLib
  module MatchHelpers
    def self.read_output_file(f)
      lines = []

      if File.exist?(f)
        fh = open(f)
        fh.each { |l| lines.push(l.chomp) }
        fh.close
      end
      return lines
    end
  end
end

RSpec::Matchers.define :be_a_valid_gem_version_file_for do |module_name|
  match do |actual|
    expect(File.exist?(actual)).to be == true
    contents = TcravitRubyLib::MatchHelpers.read_output_file(actual) 
    expect(contents[0]).to be == "module #{module_name}"
    expect(contents[1]).to match(/^\s+VERSION_DATA = \[\d+, \d+, \d+\]\s*$/)
    expect(contents[3]).to be == "end"
  end
end

RSpec::Matchers.define :declare_the_gem_version_to_be do |expected_major, expected_minor, expected_build|
  match do |actual|
    expect(File.exist?(actual)).to be == true
    contents = TcravitRubyLib::MatchHelpers.read_output_file(actual)
    v = eval(contents[1].downcase)
    expect(v[0]).to be == expected_major
    expect(v[1]).to be == expected_minor
    expect(v[2]).to be == expected_build
  end
end

RSpec::Matchers.define :be_a_rake_task_named do |name|
  match do |actual|
    expect(actual).to be_a(Rake::Task)
    expect(actual.name).to be == name
  end
end

