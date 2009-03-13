module Nfoiled
  ##
  # This is the class of a single character of input received by Nfoiled.
  class Key
    Names = {       0 => :null, 1 => :soh,  2 => :stx,  3 => :etx,
        4 => :eot,  5 => :enq,  6 => :ack,  7 => :bell, 8 => :backspace,
       10 => :nl , 11 => :vt , 12 => :np , 13 => :cr , 14 => :so ,
       15 => :si , 16 => :dle, 17 => :dc1, 18 => :dc2, 19 => :dc3,
       20 => :dc4, 21 => :nak, 22 => :syn, 23 => :etb, 24 => :can,
       25 => :em , 26 => :sub, 27 => :escape,28 => :fs,29 => :gs ,
       30 => :rs , 31 => :us ,127 => :delete}
    
    ##
    # Responsible for processing input from `Nfoiled::read!`. Returns
    def self.process charint
      return unless charint
      new case charint
        when 9, 32..126; then charint.chr
        else                  Names[charint]
      end
    end
    
    # The character corresponding to this keypress
    attr_reader :char
    
    ##
    # Creates a new `Key`. Input will be turned into a symbol if possible.
    def initialize stringish
      @char = stringish.respond_to?(:to_s) ? stringish.to_s.to_sym : stringish.to_sym
    end
  end
end
