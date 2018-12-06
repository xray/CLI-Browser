require 'browser/generic_html_parser'

class WebPageProvider
  def initialize(dependencies = {})
    @http = dependencies.fetch(:http, HTTPClient.new)
    @parser = dependencies.fetch(:parser, GenericHTMLParser.new)
    @page = Struct.new(:items)
  end

  def get(url)
    html = @http.get(url)
    response = {html: html, req_url: url}
    page_items = @parser.parse(response)
    @page.new(page_items)
  end
end