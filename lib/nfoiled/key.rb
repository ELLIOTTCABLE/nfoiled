module Nfoiled
  ##
  # This is the class of a single character of input received by Nfoiled.
  class Key
    ##
    # A container for some useful constants.
    module ASCII
      # TODO: Figure out meaning of, and proper capitalization of, some of
      # these constants.
      Null = NUL = 0; SOH = 1; STX = 2; ETX = 3; EOT = 4
      ENQ = 5; Acknowledge = ACK = 6; Bell = BEL = 7; Backspace = BS = 8
      Tab = HT = 9; Newline = NL = 10; VT = 11; NP = 12
      CarriageReturn = CR = 13; SO = 14; SI = 15; DLE = 16
      DC1 = 17; DC2 = 18; DC3 = 19; DC4 = 20
      NAK = 21; SYN = 22; ETB = 23; CAN = 24
      EM = 25; SUB = 26; Escape = ESC = 27; FS = 28
      GS = 29; RS = 30; US = 31; Delete = DEL = 127
    end
    
    ##
    # Creates a `Key` out of an ASCII integer.
    def self.ascii charint
      if (32..126).member? charint
        new charint.chr.to_sym
      elsif  Names.member? charint 
        new Names[charint]
      end
    end
    
    # The character corresponding to this keypress
    attr_reader :char
    
    ##
    # Creates a new `Key`. Input will be turned into a symbol if possible.
    def initialize stringish
      @char = stringish.respond_to?(:to_s) ? stringish.to_s.to_sym : stringish.to_sym
    end
    
    ##
    # Compares two keys' characters.
    def == o
      return false unless o.is_a? Key
      self.char == o.char
    end
  end
end
