require 'spec_helper'

describe User do
  it { should respond_to(:username) }
  it { should respond_to(:role) }
  it { should respond_to(:role?) }
end
