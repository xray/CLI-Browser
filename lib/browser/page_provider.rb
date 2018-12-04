require 'browser/web_item'
require 'nokogiri'
require 'uri'

Page = Struct.new(:items)

class PageProvider
  TAGS = %w(h1 h2 h3 h4 h5 h6 span p a)
  FULL_LINK = %r{((http|https):\/\/.*\..{3,}|www.*\..{3,6}\/)}
  LINK_PARTIAL = %r{\/.{1,}}
  URL_MINUS_SLASH = %r{((http|https):\/\/.*\..{2,8})(\/)}

  def initialize(http, page_items = {})
    @http = http
    @web_item = page_items.fetch(:web_item, WebItem)
    @link = page_items.fetch(:link, Link)
    @search_result = page_items.fetch(:search_result, SearchResult)
    @page_content = page_items.fetch(:page_content, PageContent)
  end

  def get_page(url)
    res_data = @http.get(url)
    doc = Nokogiri::HTML(res_data)
    page_title = @page_content.new(doc.css('title').first.content, 'title')
    page_items = [page_title]

    doc.css(TAGS.join(', ')).each do |text_snippet|
      if text_snippet.name == 'a'
        if text_snippet['href'] =~ FULL_LINK
          page_items << @link.new(text_snippet.content, URI(text_snippet['href']))
        elsif text_snippet['href'] =~ LINK_PARTIAL
          root_url = url.to_s.match(URL_MINUS_SLASH).captures.first
          full_link = URI(root_url + text_snippet['href'])
          page_items << @link.new(text_snippet.content, full_link)
        else
          page_items << @page_content.new('INCOMPATIBLE LINK', 'error')
        end
      else
        page_items << @page_content.new(text_snippet.content, text_snippet.name)
      end
    end
    Page.new(page_items)
  end
end
