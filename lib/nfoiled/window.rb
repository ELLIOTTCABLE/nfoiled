# coding: UTF-8

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
    
    # The status of the global 'input lock' on this window. While locked, all
    # `#getk` calls will return nil.
    # 
    # If you plan to use `#getb`, always check for a lock first - otherwise
    # you could grab a Unicode byte right from the waiting hands of a Unicode
    # character `Thread`!
    attr_accessor :input_locked
    alias_method :input_locked?, :input_locked
    def lock_input!; self.input_locked = true; end
    def unlock_input!; self.input_locked = false; end
    
    # The proc to be run when a character is received
    attr_accessor :on_key
    
    # ====================
    # = Setup / Teardown =
    # ====================
    
    ##
    # Responsible for creating a new `Window`, this will also take care of
    # initializing Ncurses if necessary. See `newwin(3X)`.
    def initialize opts = Hash.new
      Nfoiled::initialize
      
      @wrapee = ::Ncurses.newwin(
        opts[:height] ? @height = opts[:height] : ::Ncurses.LINES,
        opts[:width]  ? @width =  opts[:width]  : ::Ncurses.COLS,
        opts[:top]    ? @top =    opts[:top]    : 0,
        opts[:left]   ? @left =   opts[:left]   : 0)
      
      ::Ncurses.wtimeout(wrapee, 0) # Prevents ncurses from blocking for input
      
      (@owner = Terminal.current).windows << self
    end
    
    ##
    # Destroys the `wrapee` of this `Window`, and removes this `Window`
    # from its owning `Terminal`'s `#windows`. See `delwin(3X)`.
    def destroy!
      ::Ncurses.delwin(wrapee)
      @wrapee = nil
      owner.windows.delete self
    end
    
    # =========
    # = Input =
    # =========
    
    ##
    # Gets a single byte from the input buffer for this window. Returns nil if
    # there are no new characters in the buffer. See `wgetch(3X)`.
    def getb
      byte = ::Ncurses.wgetch(wrapee)
      byte == -1 ? nil : byte
    end
    
    ##
    # Gets a single `Key` from the input buffer for this window.
    # 
    # This will asynchronously yield the `Key` to a block you provide, if such
    # a block is given - in this mode, this method will return `true` if a
    # `getk` is currently possible (input may become temporarily locked under
    # certain circumstances), and `nil` if there is no `Key` to get.
    # 
    # For the most part, you can expect blocks to be yielded extremely
    # quickly; however, don't count on this (a sudden, large paste of long-
    # byte UTF-8 characters could cause each subsequent `getk` to take longer
    # to yield).
    # 
    # This method can also be employed in a synchronous manner if no block is
    # given; in this mode it acts as no more than a wrapper for `Window#getb`
    # that automatically processes the ASCII char into a `Key` object. Higher-
    # byte sequences such as Unicode UTF-8 will be treated as errors in this
    # mode, returning `false`. Otherwise the `Key`-wrapped ASCII is returned.
    def getk
      return nil if self.input_locked?
      byte = getb
      return byte unless byte
      if block_given?
        case byte
        when 0..127
          yield Key.ascii byte
        when 128..191, 192..193, 254..255
          yield Key.new "�"
        when 194..223, 224..239, 240..244, 245..247, 248..251, 252..253
          handle_unicode byte, &Proc.new
        end
        return true
      else # We'll synchronously return the ASCII value wrapped in a `Key`.
        case byte
        when 0..127
          return Key.ascii byte
        else
          return Key.new "�"
        end
      end
    end
    
    private
      ##
      # Handles a UTF-8 sequence from `getk`.
      def handle_unicode byte, &handler
        case byte
          when 194..223; then bytes = 2 # 2 byte sequence
          when 224..239; then bytes = 3 # 3 byte sequence
          when 240..244; then bytes = 4 # 4 byte sequence below 10FFFF
          when 245..247; then bytes = 4 # 4 byte sequence above 10FFFF
          when 248..251; then bytes = 5 # 5 byte sequence
          when 252..253; then bytes = 6 # 6 byte sequence
        end
        
        Thread.start(self, byte, bytes, handler) do |window, first_byte, bytes, handler|
          uba = [first_byte]
          
          Thread.pass while window.input_locked?
          window.lock_input!
          
          until uba.length >= bytes
            byte = getb
            if byte
              case byte
              when 0..127, 192..193, 254..255, 194..223, 224..239, 240..244, 245..247, 248..251, 252..253
                Thread.start(handler) {|handler| handler[Key.new "�"] }
                window.unlock_input!
                Thread.kill
              when 128..191
                uba << byte
              end
            end
            
            Thread.pass
          end
          
          Thread.start(handler) {|handler| handler[Key.new uba.pack('C*')] }
          window.unlock_input!
        end
      end
      
      
    public
    
    ##
    # This sets this `Window` as the current `Terminal.acceptor`.
    def focus!
      owner.acceptor = self
      update
    end
    
    ##
    # Defines a block that controls how the global input loop from
    # `Nfoiled::read!` handles input when this window has focus.
    # 
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
    def print stringish
      wrapee.printw stringish.to_s
      update
    end
    
    ##
    # Updates the virtual screen associated with this window. See `wnoutrefresh(3X)`.
    def update
      wrapee.wnoutrefresh
    end
    
    ##
    # Prints a string, followed by a newline, to the window
    def puts stringish
      self.print stringish.to_s + "\n"
    end
  end
end
