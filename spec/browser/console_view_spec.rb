require 'browser/console_view'
require 'stringio'


# Refactor setup of doubles with let statements (see browser_spec)
RSpec.describe ConsoleView do
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
        Result.new('Result Two', 'Description 2', 'https://linktwo.com')
      ]

      view.show_results(results)

      expect(out.string).to eq(
        "\n" \
        "   ┃ \033[1mResult One\033[0m\n" \
        " 1 ┃ Description 1\n" \
        "   ┃ \e[4mhttps://linkone.com\e[0m\n" \
        "\n" \
        "   ┃ \033[1mResult Two\033[0m\n" \
        " 2 ┃ Description 2\n" \
        "   ┃ \e[4mhttps://linktwo.com\e[0m\n" \
        "\n"
      )
    end

    describe 'truncate' do
      it 'by default, shortens input string to 120 characters' do
        input = StringIO.new('')
        out = StringIO.new
        test_string = 'Lorem ipsum dolor sit amet, consectetur adipiscing ' \
                      'elit. Mauris non lobortis nisi. Vivamus luctus cursus ' \
                      'mauris, eget fringilla elit tempor.'
        expect(ConsoleView.new(input, out).truncate(test_string)).to eq(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ' \
          'Mauris non lobortis nisi. Vivamus luctus cursus mauris, eget...'
        )
      end

      it 'by default, does not change strings under 120 characters' do
        input = StringIO.new('')
        out = StringIO.new
        test_string = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        expect(ConsoleView.new(input, out).truncate(test_string)).to eq(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        )
      end
    end

    describe 'get_result' do
      it 'shows the user a message' do
        input = StringIO.new
        out = StringIO.new
        view = ConsoleView.new(input, out)

        view.get_result(10)

        expect(out.string).to eq('Choose a result (1 - 10): ')
      end

      it 'returns the correct result value' do
        input = StringIO.new('4')
        out = StringIO.new
        view = ConsoleView.new(input, out)

        result = view.get_result(10)

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

  end
end
