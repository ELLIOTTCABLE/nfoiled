($:.unshift File.expand_path(File.join( File.dirname(__FILE__), '..', 'lib' ))).uniq!
require 'nfoiled'

##
# This example provides a simple example of setting up an Ncurses interface,
# and then tearing it down. Nothing will be observed other than the clearing
# of the terminal for 10 seconds.

# First, we need to ensure that Ncurses will exit cleanly (that is, we don't
# want an interrupt or fatal error to screw up the terminal output after the
# program exists).
Nfoiled::initialize

# Finally, we have to update the display. This preforms the actual clearing of
# the screen.
::Ncurses.doupdate

sleep 10
