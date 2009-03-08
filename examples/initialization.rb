($:.unshift File.expand_path(File.join( File.dirname(__FILE__), '..', 'lib' ))).uniq!
require 'nfoiled'

##
# This example provides a simple example of setting up an Ncurses interface,
# and then tearing it down. Nothing will be observed other than the clearing
# of the terminal for 10 seconds.

# A call to `Nfoiled::initialize` will, basically, do everything for us. Many
# other initialization methods actually call this for us anyway, so we could
# even just jump right in and instantiate a window if we so desired.
Nfoiled::initialize

# The only thing left to do is update the display, to actually cause it to
# display!
::Ncurses.doupdate

sleep 5
