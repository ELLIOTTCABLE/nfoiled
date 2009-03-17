($:.unshift File.expand_path(File.join( File.dirname(__FILE__), '..', 'lib' ))).uniq!
require 'nfoiled'

##
# This example shows you how to utilize an Nfoiled `Window` to accept input.

# Creating our first `Window` should take care of initializing the Nfoiled
# system for us. However, the `Ncurses.LINES` and `Ncurses.COLS` methods won't
# be defined until the system is initialized, so we have to prime it.
Nfoiled::initialize
output  = Nfoiled::Window.new :height => ::Ncurses.LINES - 1
input   = Nfoiled::Window.new :top    => ::Ncurses.LINES - 1, :height => 1

output.puts "Type characters to have them printed! (^C to exit)"
input.focus!
Nfoiled::update!

# Now we'll print each key to the output as it is typed into the input.
input.on_key do |key|
  output.print key.char.to_s + " "
  Nfoiled::update!
end

Nfoiled::read!
