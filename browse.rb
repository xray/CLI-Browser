$LOAD_PATH << File.expand_path('./lib', __dir__)

require 'browser'

browser = Browser.new(
  ConsoleView.new(STDIN, STDOUT),
  Search.new(
    DuckDuckGoSearchProvider.new(
      HTTPClient.new(),
      DuckDuckGoHTMLParser.new()
    )
  )
)

browser.start
