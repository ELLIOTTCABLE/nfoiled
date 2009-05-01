#!/usr/bin/env ruby -wKu
($:.unshift File.expand_path(File.join( File.dirname(__FILE__), 'lib' ))).uniq!
require 'nfoiled'

require 'logger'
$LOG = Logger.new File.expand_path(File.join( File.dirname(__FILE__), 'logs', 'debug.log' ))

Nfoiled::initialize
output  = Nfoiled::Window.new :height => ::Ncurses.LINES - 2
input   = Nfoiled::Window.new :top    => ::Ncurses.LINES - 1, :height => 1

::Ncurses::scrollok(output.wrapee, true)
output.print "Type characters, such as #{[225,143,156].pack('C*')} and #{[195,166].pack('C*')}, to have them printed! (^C to exit)"
input.focus!
Nfoiled::update!

while true
  Nfoiled::Terminal.current.acceptor.getk do |key|
    $LOG.debug { "Got key: #{key.inspect}" }
    # TODO: This should be handled more naturally by a Key handler or something
    exit if [Nfoiled::Key.new(:etx), Nfoiled::Key.new(:eot)].include? key # ^C, ^D
    output.print key ? key.inspect + ' ' : '.'
    input.print key.char if key
  end
end
