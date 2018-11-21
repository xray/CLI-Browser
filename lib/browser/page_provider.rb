require 'nokogiri'

WebPage = Struct.new(:title, :body, :links)
HyperLink = Struct.new(:url, :text)
WebContent = Struct.new(:type, :text)

class PageProvider
  def initialize(http)
    @http = http
  end

  def get_page(url)
    html = @http.get(url)
    doc = Nokogiri::HTML(html)
    page_title = ''
    page_contents = []
    doc.css('p, span, h1, h2, h3, h4, h5, h6, a, title').each do |item|
      if item.name == 'title'
        page_title = item.content
      elsif text_item.name == 'a'
        adjusted_url = text_item['href'].gsub(%r{\/l\/\?kh=-1&uddg=}, '').to_s
        unless adjusted_url =~ %r{(http|https):\/\/.{1,}\.[a-z]{2,10}\/}
          adjusted_url = web_url.to_s.chop + adjusted_url
        end
        link_counter += 1

        page_contents.append(HyperLink.new(adjusted_url, text_item.content))
      else
        unless text_item.content.strip == ''
          page_contents.append(WebContent.new(text_item.name, text_item.content.strip))
        end
      end
    end
  end
end
