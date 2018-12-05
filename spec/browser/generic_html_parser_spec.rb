require 'browser/generic_html_parser'

RSpec.describe GenericHTMLParser do
  let(:parser) { GenericHTMLParser.new }
  let(:html) { File.read('read_test.html') }
  let(:parsed_page) { parser.parse(html)}

  describe 'parse' do
    it 'returns a PageContent item' do
      test_page_item = parsed_page.first

      expect(test_page_item).not_to respond_to(:description, :url)
      expect(test_page_item.content).to eq 'Fake Page'
      expect(test_page_item.type).to eq 'title'
    end

    it 'returns a Link item' do
      test_page_item = parsed_page[4]

      expect(test_page_item).not_to respond_to(:description, :type)
      expect(test_page_item.content).to eq 'A link to Google'
      expect(test_page_item.url).to eq URI('https://google.com')
    end
  end
end