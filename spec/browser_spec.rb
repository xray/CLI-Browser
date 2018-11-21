require 'browser'

RSpec.describe Browser do
  let(:view) {
    double(
      get_search: 'apples',
      show_results: nil,
      get_result: 0,
      no_results: nil
    )
  }
  let(:search) {
    double(results: [])
  }
  let(:page_provider) {
    double(get_page: nil)
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
      results = [
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
      search = double(results: results)
      browser = build_browser(search: search)

      expect(view).to receive(:get_result).with(4)

      browser.start
    end
  end

  it 'fetches the selected result' do
    view = double(
      get_search: 'apples',
      show_results: nil,
      get_result: 1
    )
    results = [
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

    it '' do
    end
  end
end
