require 'browser/duckduckgo_html_parser'

RSpec.describe DuckDuckGoHTMLParser do
  let(:ddg_parser) { DuckDuckGoHTMLParser.new }

  describe 'parse' do
    it 'takes in HTML from DuckDuckGo and returns an array of Result objects' do
      current_directory = Dir.pwd
      Dir.chdir(current_directory + '/spec/fixtures')
      test_html = File.read('apples.html')
      results = ddg_parser.parse(test_html)
      expected_description = 'An apple is a sweet, edible fruit produced by' \
                             ' an apple tree (Malus pumila).Apple trees are' \
                             ' cultivated worldwide, and are the most widely' \
                             ' grown species in the genus Malus.The tree' \
                             ' originated in Central Asia, where its wild' \
                             ' ancestor, Malus sieversii, is still found' \
                             ' today.Apples have been grown for thousands of' \
                             ' years in Asia and Europe, and were brought to' \
                             ' North America by European colonists.'
      expect(results.first.title).to eq 'Apple - Wikipedia'
      expect(results.first.description).to eq expected_description
      expect(results.first.url).to eq 'https://en.wikipedia.org/wiki/Apple'
      expect(results.length).to eq 29
    end
  end
end
