require 'search_link_generator'

RSpec.describe LinkGenerator, 'when the method' do
  lg = LinkGenerator.new()
  context '"get_link" is given' do
    it 'a query it returns a Link object with a link value of a corresponding DuckDuckGo search URL' do
      query = 'basic query'
      test_link = lg.get_link(query)
      expect(test_link.link).to eq "https://duckduckgo.com/html/?q=basic+query"
    end

    it 'a query with symbols it URL encodes the query and returns a Link object with the newly created link string' do
      query = 'Basic query, now with more $YMB0L$!!'
      test_link = lg.get_link(query)
      expect(test_link.link).to eq "https://duckduckgo.com/html/?q=Basic+query,+now+with+more+$YMB0L$!!"
    end
  end
end