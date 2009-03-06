require 'ncurses'

##
# See `README.markdown`.
module Nfoiled
  Version = 0
  
  class <<self
    attr_accessor :initialized
    alias_method :initialized?, :initialized
  end
  
  ##
  # This module method is responsible for setting up the entirety of Nfoiled's
  # overall environment. It will be called before any other Nfoiled
  # functionality is allowed. In most cases, this will be called for you.
  # 
  # This method also schedules `Nfoiled::finalize` to be automatically run
  # `at_exit`.
  def self.initialize!
    self.initialized = true
    at_exit { Nfoiled.finalize }
  end
  
  ##
  # This module method ensures that Nfoiled is initialized. It simply calls
  # `Nfoiled::initialize!` if Nfoiled hasn't already been initialized.
  def self.initialize
    initialize! unless initialized?
  end
  
  ##
  # This method is responsible for tearing down any environment set up by the
  # `Ncurses::initialize!` method.
  def self.finalize!
    self.initialized = false
    ::Ncurses.endwin
  end
  
  ##
  # This module method ensures that Nfoiled is finalize. It simply calls
  # `Nfoiled::finalize!` if Nfoiled hasn't already been finalized.
  def self.finalize
    # TODO: Ensure finalization on fatal errors or interrupts
    finalize! if initialized?
  end
end
