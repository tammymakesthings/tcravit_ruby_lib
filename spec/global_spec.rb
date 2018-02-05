############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : global_spec.rb
# Specs for   : Global aspects of the tcravit_ruby_lib library (version
#               number etc.)
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

RSpec.describe "TcravitRubyLib" do
  it "should define a VERSION constant" do
    expect(TcravitRubyLib::VERSION).to_not be_nil
    expect(TcravitRubyLib::VERSION).to match(/\d+\.\d+\.\d+/)
  end

  it "should define a VERSION_DATA array" do
    expect(TcravitRubyLib::VERSION_DATA).not_to be_nil
    expect(TcravitRubyLib::VERSION_DATA.length).to be == 3
    TcravitRubyLib::VERSION_DATA.each do |i|
      expect(i).to be_a_kind_of(Numeric)
    end
  end
end
