require 'search'

RSpec.describe Search do
  it 'returns an array of Results' do
    title = 'Test Title'
    description = 'This is a test description!'
    url = 'https://www.testurl.com'
    result = Result.new(title, description, url)

    provider = double(results: [result])
    search = Search.new(provider)

    expect(provider).to receive(:results).with('apples')
    expect(search.results('apples')).to eq([result])
  end
end
