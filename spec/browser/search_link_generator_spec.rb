require 'browser/search_link_generator'

RSpec.describe LinkGenerator do
  let(:lg) { LinkGenerator.new }

  describe 'get_link' do
    it 'a query it returns a Link object with a link value of a corresponding'\
       'DuckDuckGo search URL' do
      query = 'basic query'
      test_link = lg.get_link(query)
      expect(test_link.link).to eq 'https://duckduckgo.com/html/?q=basic+query'
    end

    it 'a query with symbols it URL encodes the query and returns a Link '\
       'object with the newly created link string' do
      query = 'Basic query, now with more $YMB0L$!!'
      test_link = lg.get_link(query)
      expect(test_link.link).to eq 'https://duckduckgo.com/html/?q=Basic+query%2C+now+with+more+%24YMB0L%24%21%21'
    end
  end

  describe 'next_page' do
    it 'with a page value of 0 it returns a copy with an updated page value of'\
       ' 2 and updated corresponding link value' do
      query = 'basic query'
      test_link = lg.get_link(query)
      expect(lg.next_page(test_link).link).to eq 'https://duckduckgo.com/html/?q=basic+query&s=30&v=l&o=json&dc=30&api=%2Fd.js&kl=us-en'
    end

    it 'with a page value of 2 it returns a copy with an updated page value '\
       'of 3 and updated corresponding link value' do
      query = 'basic query'
      test_link = lg.get_link(query)
      page_two_link = lg.next_page(test_link)
      page_three_link = lg.next_page(page_two_link)
      expect(page_three_link.link).to eq 'https://duckduckgo.com/html/?q=basic+query&s=80&v=l&o=json&dc=80&api=%2Fd.js&kl=us-en'
      expect(page_three_link.page).to eq 3
    end
  end

  describe 'determine_page_number_value' do
    it '1 it returns false' do
      page_number = 1
      expect(lg.determine_page_number_value(page_number)).to eq false
    end

    it '2 it returns "30"' do
      page_number = 2
      expect(lg.determine_page_number_value(page_number)).to eq '30'
    end

    it '3 it returns "80"' do
      page_number = 3
      expect(lg.determine_page_number_value(page_number)).to eq '80'
    end
  end

  describe 'previous_page' do
    it 'with a page value of greater than 1 it returns a copy with an updated '\
       'page value of the current value minus 1 and updated corresponding '\
       'link value' do
      query = 'basic query'
      test_link = lg.get_link(query)
      page_two_link = lg.next_page(test_link)
      page_three_link = lg.next_page(page_two_link)
      back_one_link = lg.previous_page(page_three_link)
      expect(back_one_link.link).to eq 'https://duckduckgo.com/html/?q=basic+query&s=30&v=l&o=json&dc=30&api=%2Fd.js&kl=us-en'
      expect(back_one_link.page).to eq 2
    end
  end
end
