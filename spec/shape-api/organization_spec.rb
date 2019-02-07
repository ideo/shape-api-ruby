require 'helper'

describe ShapeApi::Organization do
  subject { ShapeApi::Organization }
  it { should respond_to :find_by_external_id }
end
