module TcravitRubyLib
  module Utility
    extend self
    
    def random_alphanumeric(size=16)
      alphanumerics = [('0'..'9'),('A'..'Z'),('a'..'z')].map {|range| range.to_a}.flatten
      (0...size).map { alphanumerics[Kernel.rand(alphanumerics.size)] }.join
    end
    
  end
end