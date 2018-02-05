############################################################################
# TcravitRubyLib: Random useful stuff for Ruby programming.
#
# File        : app_config_spec.rb
# Specs for   : TcravitRubyLib::AppConfig
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
require 'fileutils'

RSpec.describe "TcravitRubyLib::AppConfig" do
    
  STRING_VAL = "string"
  NUMERIC_VAL = 18293
  SYMBOLIC_VAL = :squid
  
  before(:all) do
    TcravitRubyLib::AppConfig.configure do
      string_value STRING_VAL
      numeric_value NUMERIC_VAL
      symbol_value SYMBOLIC_VAL
    end
  end
  
  it "should return the values for defined properties" do
    expect(TcravitRubyLib::AppConfig.string_value).to be == STRING_VAL
    expect(TcravitRubyLib::AppConfig.numeric_value).to be == NUMERIC_VAL
    expect(TcravitRubyLib::AppConfig.symbol_value).to be == SYMBOLIC_VAL      
  end
  
  it "should raise an error for undefined properties" do
    expect { TcravitRubyLib::AppConfig.fishpaste_value }.to raise_error
  end
  
  it "should allow me to change a configuration property" do
    TcravitRubyLib::AppConfig.string_value = "new value"
    expect(TcravitRubyLib::AppConfig.string_value).to be == "new value"
  end
  
  it "should allow me to remove a configuration property" do
    TcravitRubyLib::AppConfig.remove!(:string_value)
    expect { TcravitRubyLib::AppConfig.string_value }.to raise_error
  end
  
  it "should allow additional properties to be added" do
    TcravitRubyLib::AppConfig.configure do
      another_value 192
    end
    TcravitRubyLib::AppConfig.configure do
      and_another_value 384
    end
    expect(TcravitRubyLib::AppConfig.another_value).to be == 192
    expect(TcravitRubyLib::AppConfig.and_another_value).to be == 384
  end
  
end
