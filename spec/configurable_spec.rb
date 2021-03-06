############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : configurable_spec.rb
# Specs for   : TcravitRubyLib::Configurable
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

class ConfigurableTest
  include TcravitRubyLib::Configurable.with(:attr_a, :attr_b, :attr_c)
end

RSpec.describe "TCravitRubyLib::Configurable" do
  it "should respond to the config method and provide its configuration" do
    expect(ConfigurableTest).to respond_to(:config)
  end

  it "should respond to the Configure method and provide a space for configuration" do
    expect(ConfigurableTest).to respond_to(:configure)
  end

  it "should respond to attributes for the configuration accessors" do
    ["attr_a", "attr_b", "attr_c"].each do |a|
      expect(ConfigurableTest.config).to respond_to(a.to_sym)
      expect(ConfigurableTest.config).to respond_to("#{a}=".to_sym)
    end
    ["nonexistent_attr"].each do |a|
      expect(ConfigurableTest.config).not_to respond_to(a.to_sym)
      expect(ConfigurableTest.config).not_to respond_to("#{a}=".to_sym)
    end
  end

  it "should allow configuration" do
    ConfigurableTest.configure do
      attr_a 42
      attr_b "Squid"
      attr_c :FishPaste
    end
    expect(ConfigurableTest.config.attr_a).to be == 42
    expect(ConfigurableTest.config.attr_b).to be == "Squid"
    expect(ConfigurableTest.config.attr_c).to be == :FishPaste
  end
end
