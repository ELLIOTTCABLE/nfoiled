require File.dirname(__FILE__) + '/../../spec_helper'

describe Class do
  
  describe '#instances_respond_to?' do
    it "should return true if instances will respond to the method" do
      # I know this is ugly. Oh well.
      Object.instances_respond_to?(:respond_to?).should == true
    end
    
    it "should return false of instances will noy respond to the method" do
      # I know this is ugly. Oh well.
      Object.instances_respond_to?(:answers_to?).should == false
    end
  end
  
end
