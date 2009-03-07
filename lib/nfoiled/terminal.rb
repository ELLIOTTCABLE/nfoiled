module Nfoiled
  ##
  # An `Nfoiled::Terminal` is a specific set of Nfoiled windows and
  # configuration. In the vast majority of cases, you only need one of these,
  # and that one will be created for you by `Nfoiled::initialize`. A general
  # user shouldn't need to deal with `Terminal` at all.
  class Terminal
    
    class <<self
      # An array of known `Terminal` instances
      attr_reader :terminals
      def terminals; @terminals ||= Array.new; end
      
      # The currently active `Terminal` instance
      attr_accessor :current
      
      # The initial `Terminal` instance, if Nfoiled is initialized without an
      # existing `Terminal`.
      attr_accessor :default
    end
    
    # The IO object to which output will be managed
    attr_reader :output
    
    # The IO object on which input will be watched
    attr_reader :input
    
    # The type of the terminal ('vt102', 'xterm', etc)
    attr_reader :term
    
    # The actual terminal object as returned by Ncurses
    attr_reader :wrapee
    
    # An array of known windows belonging to this Terminal
    attr_reader :windows
    def windows; @windows ||= Array.new; end
    
    ##
    # Responsible for creating a new `Terminal`. See `newterm(3X)`.
    def initialize opts = Hash.new
      { :output => STDOUT, :input => STDIN }.merge opts
      @output = opts[:output]
      @input = opts[:input]
      @term = opts[:term]
      
      @wrapee = ::Ncurses.newterm(opts[:term], opts[:out], opts[:in])
      Terminal.current = self
      Terminal.terminals << self
      Nfoiled::initialize
    end
    
    ##
    # 'Activates' a `Terminal`, destroying all windows and environment from
    # the current `Terminal` and replacing it with those of this one.
    def activate!
      ::Ncurses.set_term(@wrapee)
      previous, Terminal.current = Terminal.current, self
      return previous
    end
    
    ##
    # Simply calls `#activate!` if this `Terminal` isn't already active.
    def activate
      activate! unless active?
    end
    
    ##
    # Simply cheks if `Terminal.current == self`
    def active?
      Terminal.current == self
    end
    
    ##
    # Destroys the `wrapee` of this `Terminal`, and removes this `Terminal`
    # from `Terminal.terminals`
    def destroy!
      old_term = activate
      ::Ncurses.endwin
      ::Ncurses.delscreen(@wrapee)
      Terminal.terminals.delete self
      @wrapee = nil
      old_term.activate if old_term
    end
  end
end
