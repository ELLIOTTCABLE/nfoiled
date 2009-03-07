module Nfoiled
  ##
  # An `Nfoiled::Window` is a "box" in the terminal to which output can be
  # printed and from which input can be received. A basic Nfoiled application
  # will utilize only one of these, a single `Window` covering the entirety
  # of the `Terminal`'s available area.
  class Window
    # This is simply an accessor for all the windows on the current Terminal.
    def windows; Terminal.current ? Terminal.current.windows : nil; end
    
    
  end
end
