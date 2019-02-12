require 'helper'

describe ShapeApi::Organization do
  subject { ShapeApi::Organization }

  context 'with external_id' do
    # any better way to do this?
    let(:filter) { 'filter[external_id]=1&page[page]=1&page[per_page]=1' }
    let(:filtered_url) { "https://www.shape.space/api/v1/organizations?#{filter}" }

    before do
      stub_request(:get, filtered_url)
        .to_return(
          headers: { content_type: 'application/vnd.api+json' },
          status: 200,
          body: JSON.generate(
            data: [{ type: 'organizations', id: 100 }],
          ),
        )
    end

    it 'should query with external_id filter' do
      ShapeApi::Organization.where(external_id: 1).first
      expect(WebMock).to have_requested(:get, filtered_url)
    end
  end

  describe '#use' do
    let(:organization) { ShapeApi::Organization.new(id: 1) }
    let(:api_url) { 'https://www.shape.space/api/v1/users/switch_org' }
    before do
      stub_request(:post, api_url)
    end

    it 'should switch the user to the organization' do
      organization.use
      expect(WebMock).to have_requested(:post, api_url)
    end
  end
end
