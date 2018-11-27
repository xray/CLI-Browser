# Delete implementation in page page_provider
# TDD page provider

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

    it 'takes in a URL and returns an object cotaining the page text and list of links' do
      url = URI('https://myfakesite.com/home.html')
      link_list = [URI('https://google.com'), URI('https://bing.com')]

      test_text = "Title: \"Fake Page\"\n" \
      "h1 | This is a h1 with fake data\n" \
      "p | A p that contains an interesting paragraph of information pertaining to the page\n" \
      "span | a short little piece of inline info\n" \
      "1) Link: \e[4mA link to Google\e[0m (https://google.com)\n" \
      "h2 | This is a h2 with more fake data\n" \
      "p | Another p with interesting information pertaining to the page\n" \
      "span | it's even shorter this time\n" \
      "2) Link: \e[4mA link to Bing\e[0m (https://bing.com)\n"
      expect(provider.get_page(url)).to eq PageData.new(test_text, link_list)
    end
  end
end
