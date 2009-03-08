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
    
    ##
    # Responsible for creating a new `Window`, this will also take care of
    # initializing Ncurses if necessary.
    def initialize opts = Hash.new
      Nfoiled::initialize
      
      @wrapee = ::Ncurses.newwin(
        opts[:height] ? @height = opts[:height] : 0,
        opts[:width]  ? @width =  opts[:width]  : 0,
        opts[:top]    ? @top =    opts[:top]    : 0,
        opts[:left]   ? @left =   opts[:left]   : 0)
      
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
  end
end
