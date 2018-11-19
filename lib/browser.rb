require 'browser/search'
require 'browser/duckduckgo_search_provider'
require 'browser/duckduckgo_html_parser'
require 'browser/http_client'
require 'browser/console_view'

class Browser
  def initialize(view, search)
    @view = view
    @search = search
  end

  def start
    query = @view.get_search
    results = @search.results(query)
    @view.show_results(results)
  end
end
