module Nfoiled
  ##
  # A `Terminal` is a specific set of Nfoiled windows and configuration. In
  # the vast majority of cases, you only need one of these, and that one will
  # be created for you by `Nfoiled::initialize`. A general user shouldn't need
  # to deal with `Terminal` at all.
  class Terminal
    
    class <<self
      def terminals; @terminals ||= Array.new; end
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
      Terminal.terminals << self
    end
    
    ##
    # Destroys the `wrapee` of this `Terminal`, and removes this `Terminal`
    # from `Terminal.terminals`.
    def destroy!
      ::Ncurses.delscreen(@wrapee)
      Terminal.terminals.delete self
    end
  end
end
