require 'duckduckgo_search_provider'
require 'duckduckgo_html_parser'
require 'net/http'
require 'uri'

RSpec.describe DuckDuckGoSearchProvider do
  let(:ddg_parser) { DuckDuckGoHTMLParser.new }
  let(:ddg_sp) { DuckDuckGoSearchProvider.new(Net::HTTP, ddg_parser) }
  let(:http) { double(get: File.read('apples.html')) }
  let(:provider) { DuckDuckGoSearchProvider.new(http, ddg_parser) }

  describe 'url' do
    it 'takes in a search query and creates a DuckDuckGo search link' do
      query = 'golden eye 64'
      expected_url = URI('https://duckduckgo.com/html/?q=golden+eye+64')
      expect(ddg_sp.url(query)).to eq expected_url
    end
  end

  it 'requests the search url' do
    expected_url = URI('https://duckduckgo.com/html/?q=apples')

    expect(http).to receive(:get).with(expected_url)

    provider.results('apples')
  end

  it 'parses response body into results' do
    results = provider.results('apples')
    expected_description = 'An apple is a sweet, edible fruit produced by' \
                           ' an apple tree (Malus pumila).Apple trees are' \
                           ' cultivated worldwide, and are the most widely' \
                           ' grown species in the genus Malus.The tree' \
                           ' originated in Central Asia, where its wild' \
                           ' ancestor, Malus sieversii, is still found' \
                           ' today.Apples have been grown for thousands of' \
                           ' years in Asia and Europe, and were brought to' \
                           ' North America by European colonists.'

    expect(results.first.title).to eq('Apple - Wikipedia')
    expect(results.first.description).to eq expected_description
    expect(results.first.url).to eq 'https://en.wikipedia.org/wiki/Apple'
    expect(results.length).to eq 29
  end
end
