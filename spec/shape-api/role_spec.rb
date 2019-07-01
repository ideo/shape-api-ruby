require 'helper'

describe ShapeApi::Role do
  subject { ShapeApi::Role }
end

describe ShapeApi::CollectionRole do
  subject { ShapeApi::CollectionRole }

  it 'has roles table name' do
    expect(subject.table_name).to eq('roles')
  end
end

describe ShapeApi::ItemRole do
  subject { ShapeApi::ItemRole }

  it 'has roles table name' do
    expect(subject.table_name).to eq('roles')
  end
end

describe ShapeApi::GroupRole do
  subject { ShapeApi::GroupRole }

  it 'has roles table name' do
    expect(subject.table_name).to eq('roles')
  end
end
