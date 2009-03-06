module Nfoiled
  ##
  # A `Terminal` is a specific set of Nfoiled windows and configuration. In
  # the vast majority of cases, you only need one of these, and that one will
  # be created for you by `Nfoiled::initialize`. A general user shouldn't need
  # to deal with `Terminal` at all.
  class Terminal
    
    ##
    # Responsible for creating a new `Terminal`. See `newterm(3X)`.
    def initialize opts = Hash.new
      { :out => STDOUT, :in => STDIN }.merge opts
      return ::Ncurses.newterm(opts[:term], opts[:out], opts[:in])
    end
  end
end
