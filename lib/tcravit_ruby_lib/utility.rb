require 'simple-password-gen'
module TcravitRubyLib
  module Utility
    extend self
    
    def random_alphanumeric(size=16, pronounceable=false)
			if pronounceable then
				return Password.pronounceable(size*2)[0..(size-1)]
			else
				return Password.random(size*2)[0..(size-1)]
			end
    end
    
  end
end
