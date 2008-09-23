##
# @see `Class#instances_respond_to?`
class Class
  
  ##
  # Checks if instances of the class respond to a method.
  # 
  # @see Object#respond_to?
  # @param [Symbol, #to_sym, #to_str] a method name
  # @return [Boolean] whether or not instances of this class respond to the method
  def instances_respond_to? meth
    meth = meth.to_sym if meth.respond_to? :to_sym
    meth = meth.to_str if meth.respond_to? :to_str
    self.instance_methods.include? meth
  end
  
end