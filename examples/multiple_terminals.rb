($:.unshift File.expand_path(File.join( File.dirname(__FILE__), '..', 'lib' ))).uniq!
require 'nfoiled'

##
# This example deals with utilizing multiple `Terminal` instances in Nfoiled.

# Creating our first `Terminal` will take care of initializing the Nfoiled
# system for us.
term1 = Nfoiled::Terminal.new

# Rembmer that creating a new `Terminal` also activates it, so `term1` is
# active right now!
Nfoiled::update!

# Let's print some content to show that the terminal exists.
term1_win = Nfoiled::Window.new
term1_win.print "This appears in `term1`."
Nfoiled::update!

sleep 2.5

# Now let's switch to `term2`.
# TODO: Figure out why this prints a slew of constant re-definition warnings.
term2 = Nfoiled::Terminal.new
Nfoiled::update!

# Let's print some content to show that the terminal exists.
term2_win = Nfoiled::Window.new
term2_win.print "This appears in `term2`."
Nfoiled::update!

sleep 2.5

# Finally, let's switch back to `term1` to show that it, also, still exists.
# TODO: Figure out why this doesn't work.
term1.activate!
Nfoiled::update!

sleep 2.5
