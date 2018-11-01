require 'search_link_generator'

RSpec.describe LinkGenerator, 'when the method' do
  lg = LinkGenerator.new
  context '"get_link" is given' do
    it 'a query it returns a Link object with a link value of a corresponding DuckDuckGo search URL' do
      query = 'basic query'
      test_link = lg.get_link(query)
      expect(test_link.link).to eq 'https://duckduckgo.com/html/?q=basic+query'
    end

    it 'a query with symbols it URL encodes the query and returns a Link object with the newly created link string' do
      query = 'Basic query, now with more $YMB0L$!!'
      test_link = lg.get_link(query)
      expect(test_link.link).to eq 'https://duckduckgo.com/html/?q=Basic+query%2C+now+with+more+%24YMB0L%24%21%21'
    end
  end

  context '"next_page" is given a Link object' do
    it 'with a page value of 0 it returns a copy with an updated page value of 2 and updated corresponding link value' do
      query = 'basic query'
      test_link = lg.get_link(query)
      expect(lg.next_page(test_link).link).to eq 'https://duckduckgo.com/html/?q=basic+query&s=30&v=l&o=json&dc=30&api=%2Fd.js&kl=us-en'
    end

    it 'with a page value of 2 it returns a copy with an updated page value of 3 and updated corresponding link value' do
      query = 'basic query'
      test_link = lg.get_link(query)
      page_two_link = lg.next_page(test_link)
      expect(lg.next_page(page_two_link).link).to eq 'https://duckduckgo.com/html/?q=basic+query&s=80&v=l&o=json&dc=80&api=%2Fd.js&kl=us-en'
    end
  end
end
