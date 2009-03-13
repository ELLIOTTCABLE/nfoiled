module Nfoiled
  ##
  # An `Nfoiled::Window` is a "box" in the terminal to which output can be
  # printed and from which input can be received. A basic Nfoiled application
  # will utilize only one of these, a single `Window` covering the entirety
  # of the `Terminal`'s available area.
  class Window
    
    class <<self
      # This is simply an accessor for all the windows on the current Terminal.
      attr_reader :windows
      def windows; Terminal.current.windows; end
    end
    
    # ==============
    # = Attributes =
    # ==============
    
    # The Y co-ordinate of the top left corner of this `Window`'s bounding box
    attr_reader :top
    # The X co-ordinate of the top left corner of this `Window`'s bounding box
    attr_reader :left
    # The height in lines of this `Window`'s bounding box
    attr_reader :height
    # The width in columns of this `Window`'s bounding box
    attr_reader :width
    
    # The actual window object as returned by Ncurses
    attr_reader :wrapee
    
    # The `Terminal` that this `Window` pertains to
    attr_reader :owner
    
    # The proc to be run when a character is received
    attr_accessor :on_key
    
    # ====================
    # = Setup / Teardown =
    # ====================
    
    ##
    # Responsible for creating a new `Window`, this will also take care of
    # initializing Ncurses if necessary.
    def initialize opts = Hash.new
      Nfoiled::initialize
      
      @wrapee = ::Ncurses.newwin(
        opts[:height] ? @height = opts[:height] : ::Ncurses.LINES,
        opts[:width]  ? @width =  opts[:width]  : ::Ncurses.COLS,
        opts[:top]    ? @top =    opts[:top]    : 0,
        opts[:left]   ? @left =   opts[:left]   : 0)
      
      ::Ncurses.wtimeout(@wrapee, 0) # Prevents ncurses from blocking for input
      
      (@owner = Terminal.current).windows << self
    end
    
    ##
    # Destroys the `wrapee` of this `Window`, and removes this `Window`
    # from its owning `Terminal`'s `#windows`.
    def destroy!
      ::Ncurses.delwin(@wrapee)
      @wrapee = nil
      @owner.windows.delete self
    end
    
    # =========
    # = Input =
    # =========
    
    # This acts as both a getter & setter, depending on whether a block is
    # passed in or not.
    def on_key
      block_given? ? @on_key = Proc.new : @on_key
    end
    
    # ==========
    # = Output =
    # ==========
    
    ##
    # Prints a string to the window
    def print string
      @wrapee.printw string
      @wrapee.wnoutrefresh
    end
    
    ##
    # Prints a string, followed by a newline, to the window
    def puts string
      self.print string.to_s + "\n"
    end
  end
end
