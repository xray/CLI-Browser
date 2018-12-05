require 'uri'
require 'browser/web_page_provider'

RSpec.describe WebPageProvider do
  let(:http) { double(get: File.read('read_test.html')) }
  let(:web_page_provider) { WebPageProvider.new(http) }

  describe 'get' do
    it 'takes in a url and returns a Page for that URL' do
      test_url = URI('https://myfakesite.com/home.html')
      test_web_page = web_page_provider.get(test_url)

      # Make these tests more robust
      # Add interaction testing such as expect to receive y
      # Maybe don't test that it responds with a specific thing, just a generic thing

      expect(test_web_page.items.first.content).to eq 'Fake Page'
    end
  end
end