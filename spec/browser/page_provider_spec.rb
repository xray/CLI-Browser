require 'browser/page_provider'
require 'uri'

RSpec.describe PageProvider do
  let(:http) { double(get: File.read('read_test.html')) }

  let(:provider) { PageProvider.new(http) }

  describe 'get_web_page' do
    it 'requests data from a page' do
      expected_url = URI('https://myfakesite.com/home.html')

      expect(http).to receive(:get).with(expected_url)

      provider.get_web_page(expected_url)
    end

    it 'takes in a URL and returns a Page' do
      url = URI('https://myfakesite.com/home.html')

      new_page = provider.get_web_page(url)

      expect(new_page.items.first.content).to eq 'Fake Page'
      expect(new_page.items.first.type).to eq 'title'
    end
  end

  describe 'get_search_results_page' do
    it 'takes in a query and returns a page with results' do
      query = 'Apples'

      new_page = provider.get_search_results_page(query)

      expect(new_page.items.first.content).to eq 'Apple - Wikipedia'
      expect(new_page.items.first.description).to eq
    end
  end
end
