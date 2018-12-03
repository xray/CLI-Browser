require 'browser'
require 'uri'

RSpec.describe Browser do
  let(:view) {
    double(
      get_search: 'apples',
      show_results: nil,
      get_option: 0,
      no_results: nil,
      show_page: nil,
      should_restart?: false
    )
  }

  let(:search) {
    double(results: [])
  }

  let(:page_provider) {
    double(get_page: PageData.new(nil, nil))
  }

  let(:results) {
    [
      Result.new(
        'Fake result 1',
        'Fake description 1',
        'https://fakeurlone.xyz'
      ),
      Result.new(
        'Fake result 2',
        'Fake description 2',
        'https://fakeurltwo.xyz'
      ),
      Result.new(
        'Fake result 3',
        'Fake description 3',
        'https://fakeurlthree.xyz'
      ),
      Result.new(
        'Fake result 4',
        'Fake description 4',
        'https://fakeurlfour.xyz'
      )
    ]
  }

  def build_browser(params = {})
    v = params.fetch(:view, view)
    s = params.fetch(:search, search)
    p = params.fetch(:page_provider, page_provider)
    Browser.new(v, s, p)
  end

  describe 'start' do
    it 'prompts the ui for a search term' do
      browser = build_browser

      expect(view).to receive(:get_search)

      browser.start
    end

    it 'gets search results' do
      browser = build_browser

      expect(search).to receive(:results).with('apples')

      browser.start
    end

    it 'shows search results' do
      results = [
        Result.new('Red Apple', '', '')
      ]
      search = double(results: results)
      browser = build_browser(search: search)

      expect(view).to receive(:show_results).with(results)

      browser.start
    end

    it 'prompts the ui for a result number' do
      search = double(results: results)
      browser = build_browser(search: search)

      expect(view).to receive(:get_option).with(results)

      browser.start
    end
  end

  it 'fetches the selected result' do
    view = double(
      get_search: 'apples',
      show_results: nil,
      get_option: 1,
      show_page: nil,
      should_restart?: false
    )
    search = double(results: results)
    browser = build_browser(view: view, search: search)

    expect(page_provider).to receive(:get_page).with(results[1].url)

    browser.start
  end

  context 'no results' do
    it 'shows no results' do
      browser = build_browser

      expect(view).not_to receive(:show_results)
      expect(view).to receive(:no_results).with('apples')

      browser.start
    end
  end

  it 'displays the given page' do
    search = double(results: results)

    display_text = "Title: \"Fake Page\"\n" \
                       "h1 | This is a h1 with fake data\n" \
                       "p | A p that contains an interesting paragraph of information pertaining to the page\n" \
                       "span | a short little piece of inline info\n" \
                       "1) Link: \e[4mA link to Google\e[0m (https://google.com)\n"
    page_data = PageData.new(display_text, [Result.new(nil, nil, URI('https://google.com'))])
    page_provider = double(get_page: page_data)
    browser = build_browser(page_provider: page_provider, search: search)

    expect(view).to receive(:show_page).with(page_data)

    browser.start
  end
end
