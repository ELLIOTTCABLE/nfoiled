($:.unshift File.expand_path(File.join( File.dirname(__FILE__), '..', 'lib' ))).uniq!
require 'nfoiled'

##
# This example deals with utilizing multiple `Terminal` instances in Nfoiled.

# Creating our first `Terminal` will take care of initializing the Nfoiled
# system for us.
term1 = Nfoiled::Terminal.new
term2 = Nfoiled::Terminal.new

# Rembmer that creating a new `Terminal` also activates it, so `term2` is
# active right now!
Nfoiled::update!

sleep 2.5

# Now let's switch to `term1`.
term1.activate!
Nfoiled::update!

sleep 2.5
