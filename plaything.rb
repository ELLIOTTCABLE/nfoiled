($:.unshift File.expand_path(File.join( File.dirname(__FILE__), 'lib' ))).uniq!
($:.unshift File.expand_path(File.join( File.dirname(__FILE__), '..', 'ncurses', 'lib' ))).uniq!
($:.unshift File.expand_path(File.join( File.dirname(__FILE__), '..', 'src', 'eventmachine', 'lib' ))).uniq!
require 'nfoiled'
require 'eventmachine'

term = Nfoiled::Terminal.new
Nfoiled::update!

module Handler
  def initialize
    @buffer = ""
  end
  
  def receive_data byte
    EventMachine::stop_event_loop if byte == "\x03" # Ctrl-C
    byte.force_encoding Encoding.find('locale')
    @buffer << byte
    check_buffer
  end
  
  private
    def check_buffer
      if @buffer.valid_encoding?
        Nfoiled::Terminal.current.acceptor.puts @buffer.inspect
        Nfoiled::update!
        @buffer = ""
      end
    end
end

EM.run{ EM.open_keyboard Handler }

Nfoiled.finalize
