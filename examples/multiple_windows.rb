($:.unshift File.expand_path(File.join( File.dirname(__FILE__), '..', 'lib' ))).uniq!
require 'nfoiled'

##
# This example shows you how to utilize a single Nfoiled window

# Creating our first `Window` should take care of initializing the Nfoiled
# system for us. However, the `Ncurses.LINES` and `Ncurses.COLS` methods won't
# be defined until the system is initialized, so we have to prime it.
Nfoiled::initialize
left  = Nfoiled::Window.new :top => 0,
                            :left => 0,
                            :height => ::Ncurses.LINES,
                            :width => ::Ncurses.COLS / 2
right = Nfoiled::Window.new :top => 0,
                            :left => ::Ncurses.COLS / 2,
                            :height => ::Ncurses.LINES,
                            :width => ::Ncurses.COLS / 2

# As per usual, the screen doesn't update until we actually tell it to.
Nfoiled::update!

# Let's print some stuff, just to see
left.print  "left-brain"
right.print "right-brain"

# ... aaaaand update again!
Nfoiled::update!

sleep 5
