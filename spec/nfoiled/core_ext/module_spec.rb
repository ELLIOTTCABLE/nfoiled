require File.dirname(__FILE__) + '/../../spec_helper'

describe Module do
  describe '#attr_*' do
    before :each do
      @class = Class.new
      @instance = @class.new
    end
    
    describe '- #attr_reader' do
      describe 'when passed a single symbol' do
        before :each do
          @class.class_eval do
            attr_reader :foo
          end
        end
        
        it 'should create a reader method' do
          @instance.should respond_to(:foo)
        end
        
        it 'should not create a writer method' do
          @instance.should_not respond_to(:foo=)
        end
        
        it 'should return nil if not initialized' do
          @instance.foo.should be_nil
        end
        
        it 'should initialize the instance variable to nil' do
          @instance.instance_eval do
            @foo.should == nil
          end
        end
      end
      
      describe 'when passed a single symbol with a default' do
        before :each do
          @class.class_eval do
            attr_reader :foo => 123
          end
        end
        
        it 'should create a reader method' do
          @instance.should respond_to(:foo)
        end
        
        it 'should not create a writer method' do
          @instance.should_not respond_to(:foo=)
        end
        
        it 'should return the default if not initialized' do
          @instance.foo.should == 123
        end
        
        it 'should initialize the instance variable to the default' do pending do
          @instance.instance_eval do
            @foo.should == 123
          end
        end end
      end
      
      describe 'when passed multiple symbols' do
        before :each do
          @class.class_eval do
            attr_reader :foo, :bar, :gaz
          end
        end
        
        it 'should create reader methods' do
          @instance.should respond_to(:foo, :bar, :gaz)
        end
        
        it 'should not create writer methods' do
          @instance.should_not respond_to(:foo=)
          @instance.should_not respond_to(:bar=)
          @instance.should_not respond_to(:gaz=)
        end
        
        it 'should return nil if not initialized' do
          @instance.foo.should == nil
          @instance.bar.should == nil
          @instance.gaz.should == nil
        end
        
        it 'should initialize the instance variables to nil' do
          @instance.instance_eval do
            @foo.should == nil
            @bar.should == nil
            @gaz.should == nil
          end
        end
      end
      
      describe 'when passed multiple symbols with defaults' do
        before :each do
          @class.class_eval do
            attr_reader :foo => 123, :bar => 456, :gaz => 789
          end
        end
        
        it 'should create reader methods' do
          @instance.should respond_to(:foo, :bar, :gaz)
        end
        
        it 'should not create writer methods' do
          @instance.should_not respond_to(:foo=)
          @instance.should_not respond_to(:bar=)
          @instance.should_not respond_to(:gaz=)
        end
        
        it 'should return their defaults if not initialized' do
          @instance.foo.should == 123
          @instance.bar.should == 456
          @instance.gaz.should == 789
        end
        
        it 'should initialize the instance variables to their defaults' do pending do
          @instance.instance_eval do
            @foo.should == 123
            @bar.should == 456
            @gaz.should == 789
          end
        end end
      end
      
      describe 'when passed a mix of symbols and symbols with defaults' do
        before :each do
          @class.class_eval do
            attr_reader :foo, {:bar => 'abc'}, :gaz, :wibble => 'def', :wobble => 'ghi'
          end
        end
        
        it 'should create reader methods' do
          @instance.should respond_to(:foo, :bar, :gaz, :wibble, :wobble)
        end
        
        it 'should not create writer methods' do
          @instance.should_not respond_to(:foo=)
          @instance.should_not respond_to(:bar=)
          @instance.should_not respond_to(:gaz=)
          @instance.should_not respond_to(:wibble=)
          @instance.should_not respond_to(:wobble=)
        end
        
        it 'should return their defaults or nil if not initialized' do
          @instance.foo.should == nil
          @instance.bar.should == 'abc'
          @instance.gaz.should == nil
          @instance.wibble.should == 'def'
          @instance.wobble.should == 'ghi'
        end
        
        it 'should initialize the instance variables to their defaults' do pending do
          @instance.instance_eval do
            @foo.should == nil
            @bar.should == 'abc'
            @gaz.should == nil
            @wibble.should == 'def'
            @wobble.should == 'ghi'
          end
        end end
      end
    end
    
    describe '- #attr_writer' do
      describe 'when passed a single symbol' do
        before :each do
          @class.class_eval do
            attr_writer :foo
          end
        end
        
        it 'should not create a reader method' do
          @instance.should_not respond_to(:foo)
        end
        
        it 'should create a writer method' do
          @instance.should respond_to(:foo=)
        end
        
        it 'should change the instance variable' do
          @instance.foo = 123
          
          @instance.instance_eval do
            @foo.should == 123
          end
        end
      end
      
      describe 'when passed a single symbol with a default' do
        before :each do
          @class.class_eval do
            attr_writer :foo => 123
          end
        end
        
        it 'should not create a reader method' do
          @instance.should_not respond_to(:foo)
        end
        
        it 'should create a writer method' do
          @instance.should respond_to(:foo=)
        end
        
        it 'should change the instance variable' do
          @instance.foo = 123
          
          @instance.instance_eval do
            @foo.should == 123
          end
        end
      end
      
      describe 'when passed multiple symbols' do
        before :each do
          @class.class_eval do
            attr_writer :foo, :bar, :gaz
          end
        end
        
        it 'should not create a reader method' do
          @instance.should_not respond_to(:foo)
          @instance.should_not respond_to(:bar)
          @instance.should_not respond_to(:gaz)
        end
        
        it 'should create writer methods' do
          @instance.should respond_to(:foo=, :bar=, :gaz=)
        end
        
        it 'should change the instance variables' do
          @instance.foo = 123
          @instance.bar = 456
          @instance.gaz = 789
          
          @instance.instance_eval do
            @foo.should == 123
            @bar.should == 456
            @gaz.should == 789
          end
        end
      end
      
      describe 'when passed multiple symbols with defaults' do
        before :each do
          @class.class_eval do
            attr_writer :foo => 123, :bar => 456, :gaz => 789
          end
        end
        
        it 'should not create a reader method' do
          @instance.should_not respond_to(:foo)
          @instance.should_not respond_to(:bar)
          @instance.should_not respond_to(:gaz)
        end
        
        it 'should create writer methods' do
          @instance.should respond_to(:foo=, :bar=, :gaz=)
        end
        
        it 'should change the instance variables' do
          @instance.foo = 123
          @instance.bar = 456
          @instance.gaz = 789
          
          @instance.instance_eval do
            @foo.should == 123
            @bar.should == 456
            @gaz.should == 789
          end
        end
      end
      
      describe 'when passed a mix of symbols and symbols with defaults' do
        before :each do
          @class.class_eval do
            attr_writer :foo, {:bar => 'abc'}, :gaz, :wibble => 'def', :wobble => 'ghi'
          end
        end
        
        it 'should not create a reader method' do
          @instance.should_not respond_to(:foo)
          @instance.should_not respond_to(:bar)
          @instance.should_not respond_to(:gaz)
          @instance.should_not respond_to(:wibble)
          @instance.should_not respond_to(:wobble)
        end
        
        it 'should create writer methods' do
          @instance.should respond_to(:foo=, :bar=, :gaz=, :wibble=, :wobble=)
        end
        
        it 'should change the instance variables' do
          @instance.foo = 123
          @instance.bar = 456
          @instance.gaz = 789
          @instance.wibble = 'abc'
          @instance.wobble = 'def'
          
          @instance.instance_eval do
            @foo.should == 123
            @bar.should == 456
            @gaz.should == 789
            @wibble.should == 'abc'
            @wobble.should == 'def'
          end
        end
      end
    end
    
    describe '- #attr_accessor' do
      describe 'when passed a single symbol' do
        before :each do
          @class.class_eval do
            attr_accessor :foo
          end
        end
        
        it 'should create a reader method' do
          @instance.should respond_to(:foo)
        end
        
        it 'should create a writer method' do
          @instance.should respond_to(:foo=)
        end
        
        it 'should return nil if not initialized' do
          @instance.foo.should be_nil
        end
        
        it 'should initialize the instance variable to nil' do
          @instance.instance_eval do
            @foo.should == nil
          end
        end
        
        it 'should change the instance variable' do
          @instance.foo = 123
          
          @instance.instance_eval do
            @foo.should == 123
          end
        end
      end
      
      describe 'when passed a single symbol with a default' do
        before :each do
          @class.class_eval do
            attr_accessor :foo => 123
          end
        end
        
        it 'should create a accessor method' do
          @instance.should respond_to(:foo)
        end
        
        it 'should return the default if not initialized' do
          @instance.foo.should == 123
        end
        
        it 'should initialize the instance variable to the default' do pending do
          @instance.instance_eval do
            @foo.should == 123
          end
        end end
        
        it 'should change the instance variable' do
          @instance.foo = 'abc'
          
          @instance.instance_eval do
            @foo.should == 'abc'
          end
        end
      end
      
      describe 'when passed multiple symbols' do
        before :each do
          @class.class_eval do
            attr_accessor :foo, :bar, :gaz
          end
        end
        
        it 'should create accessor methods' do
          @instance.should respond_to(:foo, :bar, :gaz)
          @instance.should respond_to(:foo=, :bar=, :gaz=)
        end
        
        it 'should return nil if not initialized' do
          @instance.foo.should == nil
          @instance.bar.should == nil
          @instance.gaz.should == nil
        end
        
        it 'should initialize the instance variables to nil' do
          @instance.instance_eval do
            @foo.should == nil
            @bar.should == nil
            @gaz.should == nil
          end
        end
        
        it 'should change the instance variables' do
          @instance.foo = 123
          @instance.bar = 456
          @instance.gaz = 789
          
          @instance.instance_eval do
            @foo.should == 123
            @bar.should == 456
            @gaz.should == 789
          end
        end
      end
      
      describe 'when passed multiple symbols with defaults' do
        before :each do
          @class.class_eval do
            attr_accessor :foo => 123, :bar => 456, :gaz => 789
          end
        end
        
        it 'should create accessor methods' do
          @instance.should respond_to(:foo, :bar, :gaz)
          @instance.should respond_to(:foo=, :bar=, :gaz=)
        end
        
        it 'should return their defaults if not initialized' do
          @instance.foo.should == 123
          @instance.bar.should == 456
          @instance.gaz.should == 789
        end
        
        it 'should initialize the instance variables to their defaults' do pending do
          @instance.instance_eval do
            @foo.should == 123
            @bar.should == 456
            @gaz.should == 789
          end
        end end 
        
        it 'should change the instance variables' do
          @instance.foo = 'abc'
          @instance.bar = 'def'
          @instance.gaz = 'ghi'
          
          @instance.instance_eval do
            @foo.should == 'abc'
            @bar.should == 'def'
            @gaz.should == 'ghi'
          end
        end
      end
      
      describe 'when passed a mix of symbols and symbols with defaults' do
        before :each do
          @class.class_eval do
            attr_accessor :foo, {:bar => 'abc'}, :gaz, :wibble => 'def', :wobble => 'ghi'
          end
        end
        
        it 'should create accessor methods' do
          @instance.should respond_to(:foo, :bar, :gaz, :wibble, :wobble)
          @instance.should respond_to(:foo=, :bar=, :gaz=, :wibble=, :wobble=)
        end
        
        it 'should return their defaults or nil if not initialized' do
          @instance.foo.should == nil
          @instance.bar.should == 'abc'
          @instance.gaz.should == nil
          @instance.wibble.should == 'def'
          @instance.wobble.should == 'ghi'
        end
        
        it 'should initialize the instance variables to their defaults' do pending do
          @instance.instance_eval do
            @foo.should == nil
            @bar.should == 'abc'
            @gaz.should == nil
            @wibble.should == 'def'
            @wobble.should == 'ghi'
          end
        end end
        
        it 'should change the instance variables' do
          @instance.foo = 123
          @instance.bar = 456
          @instance.gaz = 789
          @instance.wibble = 'abc'
          @instance.wobble = 'def'
          
          @instance.instance_eval do
            @foo.should == 123
            @bar.should == 456
            @gaz.should == 789
            @wibble.should == 'abc'
            @wobble.should == 'def'
          end
        end
      end
    end
    
  end
end
