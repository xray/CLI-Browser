require 'uri'
require 'browser/web_page_provider'

RSpec.describe WebPageProvider do
  let(:http) { double(get: File.read('read_test.html')) }
  let(:parser) { double(parse: []) }
  let(:web_page_provider) { WebPageProvider.new(http: http) }
  let(:test_url) { URI('https://myfakesite.com/home.html') }

  describe 'get' do
    it 'takes in a url' do
      expect(web_page_provider).to receive(:get).with(test_url)

      web_page_provider.get(test_url)
    end

    it 'uses http to request the url' do
      expect(http).to receive(:get).with(test_url)

      web_page_provider.get(test_url)
    end

    it 'sends the html and requested url to the parser' do
      dependencies = {
        http: http,
        parser: parser
      }
      test_wpp = WebPageProvider.new(dependencies)
      test_response = { html: http.get, req_url: test_url }

      expect(parser).to receive(:parse).with(test_response)

      test_wpp.get(test_url)
    end

    it 'returns the parsed html as a Page' do
      page_response = web_page_provider.get(test_url)

      expect(page_response).to respond_to(:items)
      expect(page_response.items.first).to respond_to(:content, :type)
      expect(page_response.items.first).not_to respond_to(:url, :description)
    end
  end
end