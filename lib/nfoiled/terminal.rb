module Nfoiled
  ##
  # A `Terminal` is a specific set of Nfoiled windows and configuration. In
  # the vast majority of cases, you only need one of these, and that one will
  # be created for you by `Nfoiled::initialize`. A general user shouldn't need
  # to deal with `Terminal` at all.
  class Terminal
    
    class <<self
      @terminals = Array.new
      attr_reader :terminals
    end
    
    attr_reader :output
    attr_reader :input
    attr_reader :term
    attr_reader :wrapee
    
    ##
    # Responsible for creating a new `Terminal`. See `newterm(3X)`.
    def initialize opts = Hash.new
      { :output => STDOUT, :input => STDIN }.merge opts
      @output = opts[:output]
      @input = opts[:input]
      @term = opts[:term]
      
      @wrapee = ::Ncurses.newterm(opts[:term], opts[:out], opts[:in])
      terminals << @wrapee
    end
  end
end
