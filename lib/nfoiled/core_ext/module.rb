class Module
  
  ##
  # The core method, this takes a hash of attributes and their defaults, as
  # well as some options, and creates accessor methods for them.
  # 
  #     class Something
  #       attr_splat :foo
  #       attr_splat :bar, :reader => true, :writer => true
  #       attr_splat :gaz => "abc", :writer => true
  #       attr_splat :wibble => 123, :wobble => 456, :waggle =>789
  #                     :reader => false, :writer => true
  #     end
  # 
  # By default, it will provide both a reader and a writer.
  # 
  # *This method can't currently be properly documented using YARDoc!*
  def attr_splat *args
    # This should really be a constant, but YARDoc has trouble parsing it for
    # some reason.
    defaults = {:reader => true, :writer => true}
    
    options = defaults.merge args.
      map {|e| e.is_a?(Hash) ? e : {e => nil} }.
      inject(Hash.new) {|e, acc| acc.merge e }
    attributes = options.reject {|k,v| [:reader, :writer].include? k.to_sym }
    
    attributes.each do |attribute, default|
      reader    = attribute
      writer    = "#{attribute}="
      attribute = "@#{attribute}"
      
      define_method reader do
        return instance_variable_get(attribute) if instance_variables.include? attribute
        instance_variable_set attribute, default
      end if options[:reader]
      
      define_method writer do |value|
        instance_variable_set attribute, value
      end if options[:writer]
    end
  end
  
  private
    alias_method :__attr_reader__, :attr_reader
    alias_method :__attr_writer__, :attr_writer
    alias_method :__attr_accessor__, :attr_accessor
  public
  
  # attr_* must be a keyword, we can't use the def keyword.
  define_method :attr_reader do |*args|
    attr_splat *[{:reader => true, :writer => false}, args].flatten
  end
  define_method :attr_writer do |*args|
    attr_splat *[{:reader => false, :writer => true}, args].flatten
  end
  define_method :attr_accessor do |*args|
    attr_splat *[{:reader => true, :writer => true}, args].flatten
  end
end
