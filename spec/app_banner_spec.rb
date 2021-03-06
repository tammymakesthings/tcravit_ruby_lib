############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : app_banner_spec.rb
# Specs for   : TcravitRubyLib::AppBanner
############################################################################
#  Copyright 2011-2018, Tammy Cravit.
# 
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
############################################################################

require 'spec_helper'

RSpec.describe "TcravitRubyLib::AppBanner" do

  context "the basics" do
    it "to format the app banner correctly" do
      ab = TcravitRubyLib::Banner(name: "MyApp")
      lines = ab.split("\n")
      expect(lines[0]).to be == ("*" * 76)
      expect(lines[2]).to be == ("*" * 76)
    end
  end 

  context "app banner components" do
    it "to allow you to make a banner with just a name" do
      ab = TcravitRubyLib::Banner(name: "MyApp")
      lines = ab.split("\n")
      expect(lines[1]).to match(/^\*\s+MyApp\s+\*$/)
      expect(lines[1].length).to be == 76
    end

    it "to allow you to make a banner with a name and description" do
      ab = TcravitRubyLib::Banner(name: "MyApp", description: "Do some super cool stuff")
      lines = ab.split("\n")
      expect(lines[1]).to match(/^\*\s+MyApp: Do some super cool stuff\s+\*$/)
      expect(lines[1].length).to be == 76
    end

    it "to allow you to make a banner with a name and date" do
      ab = TcravitRubyLib::Banner(name: "MyApp", date: "2018-01-01")
      lines = ab.split("\n")
      expect(lines[1]).to match(/^\*\s+MyApp\s+\*$/)
      expect(lines[1].length).to be == 76
      expect(lines[2]).to match(/^\*\s+2018-01-01\s+\*$/)
      expect(lines[2].length).to be == 76
    end

    it "to allow you to make a banner with a name, date, description" do
      ab = TcravitRubyLib::Banner(name: "MyApp", description: "Do some super cool stuff", date: "2018-01-01")
      lines = ab.split("\n")
      expect(lines[1]).to match(/^\*\s+MyApp: Do some super cool stuff\s+\*$/)
      expect(lines[1].length).to be == 76
      expect(lines[2]).to match(/^\*\s+2018-01-01\s+\*$/)
      expect(lines[2].length).to be == 76
    end

    it "to allow you to make a banner with a name, date, description, version" do
      ab = TcravitRubyLib::Banner(name: "MyApp", description: "Do some super cool stuff", date: "2018-01-01", version: "1.0.1")
      lines = ab.split("\n")
      expect(lines[1]).to match(/^\*\s+MyApp: Do some super cool stuff\s+\*$/)
      expect(lines[1].length).to be == 76
      expect(lines[2]).to match(/^\*\s+Version 1.0.1, 2018-01-01\s+\*$/)
      expect(lines[2].length).to be == 76
    end

    it "to allow you to make a banner with a name, date, description, version, author" do
      ab = TcravitRubyLib::Banner(name: "MyApp", description: "Do some super cool stuff", date: "2018-01-01", version: "1.0.1", author: "John Doe")
      lines = ab.split("\n")
      expect(lines[1]).to match(/^\*\s+MyApp: Do some super cool stuff\s+\*$/)
      expect(lines[1].length).to be == 76
      expect(lines[2]).to match(/^\*\s+Version 1.0.1, 2018-01-01, John Doe\s+\*$/)
      expect(lines[2].length).to be == 76
    end
  end

  context "error handling" do
    it "to raise an error if the name is not provided" do
      expect {TcravitRubyLib::Banner(description: "Foo")}.to raise_error(ArgumentError)
    end

    it "to raise an error if the description is too long" do
      expect {TcravitRubyLib::Banner(description: ("*" * 133), line_length: 76)}.to raise_error(ArgumentError)
      expect {TcravitRubyLib::Banner(description: ("*" * 128), line_length: 133)}.to raise_error(ArgumentError)
    end
  end

  context "formatting" do
    it "to allow you to change the output line length" do
      ab = TcravitRubyLib::Banner(name: "MyApp", description: "Do some super cool stuff", line_length: 133)
      lines = ab.split("\n")
      expect(lines[0]).to be == ("*" * 133)
      expect(lines[1]).to match(/^\*\s+MyApp: Do some super cool stuff\s+\*$/)
      expect(lines[1].length).to be == 133
      expect(lines[2]).to be == ("*" * 133)
    end
  end
end
