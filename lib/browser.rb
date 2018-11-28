require 'browser/search'
require 'browser/duckduckgo_search_provider'
require 'browser/duckduckgo_html_parser'
require 'browser/http_client'
require 'browser/console_view'
require 'browser/page_provider'

class Browser
  def initialize(view, search, page_provider)
    @view = view
    @search = search
    @page_provider = page_provider
  end

  def start
    query = @view.get_search
    results = @search.results(query)
    if results.empty?
      @view.no_results(query)
    else
      @view.show_results(results)
      chosen_result_index = @view.get_result(results.length)
      chosen_result = results[chosen_result_index]
      page = @page_provider.get_page(chosen_result.url)
      @view.show_page(page)
    end
  end
end
