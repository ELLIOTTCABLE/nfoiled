require 'ncurses'

##
# See `README.markdown`.
module Nfoiled
  VERSION = 0
  
  ##
  # This module method is responsible for setting up the entirety of Nfoiled's
  # overall environment. It will be called before any other Nfoiled
  # functionality is allowed. In most cases, this will be called for you.
  def self.initialize!
    @@initialized = true
  end
  
  ##
  # This module method ensures that Nfoiled is initialized. It simply calls
  # `Nfoiled::initialize!` if Nfoiled hasn't already been initialized.
  def self.initialize
    initialize! unless @@initialized
  end
  
  ##
  # This method is
  def self.finalize!
    @@initialized = false
  end
end
