require 'spec_helper'

describe User do
  it "should have a name" do
    subject.should respond_to(:username)
  end
end
