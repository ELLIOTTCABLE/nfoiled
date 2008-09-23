require File.dirname(__FILE__) + '/../../spec_helper'

describe Symbol do
  it "should provide #to_str" do
    :symbol.should respond_to(:to_str)
  end
end
