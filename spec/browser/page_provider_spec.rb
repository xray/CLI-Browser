require 'browser/page_provider'
require 'uri'

RSpec.describe PageProvider do
  let(:http) { double(get: File.read('read_test.html')) }

  let(:provider) { PageProvider.new(http) }

  describe 'get_page' do
    it 'requests data from a page' do
      expected_url = URI('https://myfakesite.com/home.html')

      expect(http).to receive(:get).with(expected_url)

      provider.get_page(expected_url)
    end

    it 'takes in a URL and returns a Page' do
      url = URI('https://myfakesite.com/home.html')

      test_provider = PageProvider.new(http)

      new_page = test_provider.get_page(url)

      expect(new_page.items.first.content).to eq 'Fake Page'
      expect(new_page.items.first.type).to eq 'title'
    end
  end
end
