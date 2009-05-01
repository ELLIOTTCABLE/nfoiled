#!/usr/bin/env ruby -wKu
($:.unshift File.expand_path(File.join( File.dirname(__FILE__), 'lib' ))).uniq!
require 'nfoiled'

Nfoiled::initialize
stream  = Nfoiled::Window.new :top => 0, :height => 1
output  = Nfoiled::Window.new :top => 1, :height => ::Ncurses.LINES - 2
input   = Nfoiled::Window.new :top => ::Ncurses.LINES - 1, :height => 1

::Ncurses::scrollok(stream.wrapee, true)
::Ncurses::scrollok(output.wrapee, true)
stream.print "Type characters, such as #{[225,143,156].pack('C*')} and #{[195,166].pack('C*')}, to have them printed! (^C to exit)"
input.focus!
Nfoiled::update!

start = false
nils = 0
characters = []
current_byte_string = []
bytes_left = 0
while true
  key = Ncurses::wgetch(input.wrapee)
  
  if key == -1
    if start
      output.print '.'
      nils += 1
    end
  else
    start = true unless start
    nils = 0
    raise Interrupt.new if
      [3, 4].include? key # ^C, ^D
    # Now we send it to the decoder
    
    case key
      when 0..127;   then current_byte_string = [key] and bytes_left = 0
      when 128..191; then current_byte_string << key and bytes_left -= 1
      when 192..193; then raise "Overlong encoding"
      when 194..223; then current_byte_string = [key] and bytes_left = 1 # 2 byte sequence
      when 224..239; then current_byte_string = [key] and bytes_left = 2 # 3 byte sequence
      when 240..244; then current_byte_string = [key] and bytes_left = 3 # 4 byte sequence below 10FFFF
      when 245..247; then current_byte_string = [key] and bytes_left = 3 # 4 byte sequence above 10FFFF
      when 248..251; then current_byte_string = [key] and bytes_left = 4 # 5 byte sequence
      when 252..253; then current_byte_string = [key] and bytes_left = 5 # 6 byte sequence
      when 254..255; then raise "Invalid byte"
    end
    
    if bytes_left == 0
      characters << current_byte_string.pack('C*')
      output.print '!'
      stream.print "\n" + characters.inspect
      input.print characters.last
    end
    
    output.print key.inspect
  end
  
  exit if nils > 5000
end
