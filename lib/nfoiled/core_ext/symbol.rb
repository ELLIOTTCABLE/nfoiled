##
# @see `Symbol#to_str`
class Symbol
  
  ##
  # We define this for semantic purposes - the general convention is that the
  # `#to_x` methods are supposed to be more flexible than the `#to_xxx`
  # methods. A `#to_s` method implies that an object can be coerced into an
  # `Xxxxx`, but that doesn't necessarily mean an `Xxxxx` representation of
  # the object is *equivalent*. However, a `#to_xxx` method implies that the
  # `Xxxxx` representation of the object is equivalent to the original
  # representation - therefore conversions of `foo.to_xxx` and the resulting
  # `xxx.to_foo` are non-destructive.
  # 
  # Unfortunately, Ruby doesn't really define these the implicit
  # conversions for a lot of Core types, and symbol is especially annoying -
  # it's quite useful to duck punch methods with `#to_str` or `#to_int`, etc - 
  # `raise ArgumentError unless arg.respond_to? :to_str` is probably one of
  # the most commonly repeated lines in all the code I've ever written.
  # 
  # Hence, this method - almost exclusively defined for duck punching purposes.
  def to_str(*args)
    # Come on, YARD, provide support for `alias_method`!
    to_s(*args)
  end
  
end
