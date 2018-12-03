require 'browser/console_view'
require 'stringio'
require 'uri'


# Refactor setup of doubles with let statements (see browser_spec)
RSpec.describe ConsoleView do
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

  describe 'get_search' do
    it 'shows the user a message' do
      input = StringIO.new
      out = StringIO.new
      view = ConsoleView.new(input, out)

      view.get_search

      expect(out.string).to eq('Enter a search term: ')
    end

    it 'returns the provided term' do
      input = StringIO.new('oranges')
      out = StringIO.new
      view = ConsoleView.new(input, out)

      search = view.get_search

      expect(search).to eq('oranges')
    end
  end

  describe 'show_results' do
    it 'displays results' do
      input = StringIO.new('oranges')
      out = StringIO.new
      view = ConsoleView.new(input, out)
      results = [
        Result.new('Result One', 'Description 1', 'https://linkone.com'),
        Result.new('Result Two',
                   'Lorem ipsum dolor sit amet, consectetur adipiscing ' \
                   'elit. Mauris non lobortis nisi. Vivamus luctus cursus ' \
                   'mauris, eget fringilla elit tempor.',
                   'https://linktwo.com')
      ]

      view.show_results(results)

      expect(out.string).to eq(
        "\n" \
        "   ┃ \033[1mResult One\033[0m\n" \
        " 1 ┃ Description 1\n" \
        "   ┃ \e[4mhttps://linkone.com\e[0m\n" \
        "\n" \
        "   ┃ \033[1mResult Two\033[0m\n" \
        ' 2 ┃ Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris' \
        " non lobortis nisi. Vivamus luctus cursus mauris, eget...\n" \
        "   ┃ \e[4mhttps://linktwo.com\e[0m\n" \
        "\n"
      )
    end

    describe 'get_option' do
      it 'shows the user a message' do
        input = StringIO.new
        out = StringIO.new
        view = ConsoleView.new(input, out)

        view.get_option(results)

        expect(out.string).to eq('Choose an option (1 - 4): ')
      end

      it 'returns the correct result value' do
        input = StringIO.new('4')
        out = StringIO.new
        view = ConsoleView.new(input, out)

        result = view.get_option(results)

        expect(result).to eq(3)
      end
    end

    describe 'no_results' do
      it 'shows a no results message' do
        input = StringIO.new('4')
        out = StringIO.new
        view = ConsoleView.new(input, out)
        query = 'apples'
        view.no_results(query)
        expect(out.string).to eq "'#{query}' returned no results...\n"
      end
    end

    describe 'show_page' do
      it 'takes in PageData and displays the page' do
        input = StringIO.new('test page')
        out = StringIO.new
        view = ConsoleView.new(input, out)
        display_text = "Title: \"Fake Page\"\n" \
                       "h1 | This is a h1 with fake data\n" \
                       "p | A p that contains an interesting paragraph of information pertaining to the page\n" \
                       "span | a short little piece of inline info\n" \
                       "1) Link: \e[4mA link to Google\e[0m (https://google.com)\n"
        fake_data = PageData.new(display_text, [URI('https://google.com')])

        view.show_page(fake_data)
        expect(out.string).to eq(display_text)
      end
    end
  end
end
