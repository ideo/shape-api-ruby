require 'helper'

describe ShapeApi::User do
  subject { ShapeApi::User }
  it { should respond_to :create_from_emails }
end
