($:.unshift File.expand_path(File.join( File.dirname(__FILE__), '..', 'lib' ))).uniq!
require 'nfoiled'

##
# This simple example deals with utilizing a single `Window` instance in
# Nfoiled.
window = Nfoiled::Window.new
window.print "Hi!"
Nfoiled::update!

sleep 2.5
