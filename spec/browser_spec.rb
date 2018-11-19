require 'browser'

RSpec.describe Browser do
  describe 'start' do
    it 'prompts the ui for a search term' do
      view = double(get_search: 'apples', show_results: nil)
      search = double(results: [])
      browser = Browser.new(view, search)

      expect(view).to receive(:get_search)

      browser.start
    end

    it 'gets search results' do
      view = double(get_search: 'apples', show_results: nil)
      search = double(results: [])
      browser = Browser.new(view, search)

      expect(search).to receive(:results).with('apples')

      browser.start
    end

    it 'shows search results' do
      view = double(get_search: 'apples')
      results = [
        Result.new('Red Apple', '', '')
      ]
      search = double(results: results)
      browser = Browser.new(view, search)

      expect(view).to receive(:show_results).with(results)

      browser.start
    end
  end
end
