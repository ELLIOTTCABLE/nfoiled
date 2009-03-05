($:.unshift File.expand_path(File.join( File.dirname(__FILE__), '..', 'lib' ))).uniq!
require 'nfoiled'

##
# This example provides a simple example of setting up an Ncurses interface,
# and then tearing it down.

# First, we need to ensure that Ncurses will exit cleanly (that is, we don't
# want an interrupt or fatal error to screw up the terminal output after the
# program exists).
at_exit { ::Ncurses.endwin }

# Second, the actual initialization of Ncurses. This allocates the necessary
# memory and initializes all variables.
::Ncurses.initscr

# Finally, we have to update the display.
::Ncurses.doupdate

# Let's print something and exit!
puts "woot!"

sleep 10
