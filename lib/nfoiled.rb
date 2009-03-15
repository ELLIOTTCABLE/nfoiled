require 'ncurses'

require 'nfoiled/key'
require 'nfoiled/terminal'
require 'nfoiled/window'

##
# See `README.markdown`.
module Nfoiled
  Version = 0
  
  class <<self
    attr_accessor :initialized; alias_method :initialized?, :initialized
    
    ##
    # This module method is responsible for setting up the entirety of Nfoiled's
    # overall environment. It will be called before any other Nfoiled
    # functionality is allowed. In most cases, this will be called for you.
    # 
    # This method also schedules `Nfoiled::finalize` to be automatically run
    # `at_exit`.
    def initialize!
      self.initialized = true
      Terminal.default = Terminal.new unless Terminal.current
      
      ::Ncurses.noecho # Characters will not be printed to the terminal by Ncurses for us
      ::Ncurses.cbreak # No character processing is done, each individual character will be returned to `#getch`
      ::Ncurses.raw    # Interrupt etc signals are all directed to us instead of handled by Ncurses
      
      at_exit { Nfoiled.finalize }
    end
    
    ##
    # This module method ensures that Nfoiled is initialized. It simply calls
    # `Nfoiled::initialize!` if Nfoiled hasn't already been initialized.
    def initialize
      initialize! unless initialized?
    end
    public :initialize
    
    ##
    # Causes an cycling of the physical window with the virtual window.
    # 
    # Warning: You have to update the virtual window first!
    def update!
      # We need to ensure that the current input acceptor will have the cursor
      # at all times, so we force a refresh on it (Ncurses leaves the cursor
      # on the last window to be updated). See `doupdate(3X)`.
      Terminal.current.acceptor.update
      ::Ncurses.doupdate
    end
    
    ##
    # This method is responsible for tearing down any environment set up by the
    # `Ncurses::initialize!` method. See `endwin(3X)`.
    def finalize!
      self.initialized = false
      ::Ncurses.endwin
      Terminal.terminals.each {|t| t.destroy! }
      Terminal.current, Terminal.default = nil
    end
    
    ##
    # This module method ensures that Nfoiled is finalize. It simply calls
    # `Nfoiled::finalize!` if Nfoiled hasn't already been finalized.
    def finalize
      # TODO: Ensure finalization on fatal errors or interrupts
      finalize! if initialized?
    end
    
    ##
    # This handles the global "input loop". Each character is processed into a
    # `Key`, and then passed to the current input acceptor's `on_key` block
    # (if such a block has been defined). See `getch(3X)`.
    def read!
      while true
        key = Terminal.current.acceptor.getk
        # TODO: This should be handled more naturally by a Key handler or something
        exit if [Key.new(:etx), Key.new(:eot)].include? key # ^C, ^D
        Terminal.current.acceptor.on_key[key] if key
      end
    end
  end
  
end
