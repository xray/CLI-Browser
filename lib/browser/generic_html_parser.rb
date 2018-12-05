require 'nokogiri'
require 'browser/page_item'

class GenericHTMLParser
  TAGS = %w(h1 h2 h3 h4 h5 h6 span p a)
  FULL_LINK = %r{((http|https):\/\/.*\..{3,}|www.*\..{3,6}\/)}
  LINK_PARTIAL = %r{\/.{1,}}
  URL_MINUS_SLASH = %r{((http|https):\/\/.*\..{2,8})(\/)}

  def initialize(page_item_types = {})
    @link = page_item_types.fetch(:link, Link)
    @page_content = page_item_types.fetch(:page_content, PageContent)
  end

  def parse(html, url)
    doc = Nokogiri::HTML(html)
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
    page_items
  end
end