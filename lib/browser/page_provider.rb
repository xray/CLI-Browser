require 'nokogiri'
require 'uri'

PageData = Struct.new(:text, :links)

class PageProvider
  def initialize(http)
    @http = http
  end

  def get_page(url)
    res_data = @http.get(url)
    doc = Nokogiri::HTML(res_data)
    page_text = []
    page_title = "Title: \"#{doc.css('title').first.content}\"\n"
    page_text.push(page_title)
    link_list = []
    link_count = 0
    tags = %w(h1 h2 h3 h4 h5 h6 span p a)
    doc.css(tags.join(', ')).each do |text_snippet|
      if text_snippet.name == 'a'
        if text_snippet['href'] =~ %r{((http|https):\/\/.*\..{3,}|www.*\..{3,6}\/)}
          link_list << Result.new(nil, nil, URI(text_snippet['href']))
          link_count += 1
          page_text << "#{link_count}) Link: \e[4m#{text_snippet.content}\e[0m (#{text_snippet['href']})\n"
        elsif text_snippet['href'] =~ %r{\/.{1,}}
          root_url = url.to_s.match(%r{((http|https):\/\/.*\..{2,8})(\/)}).captures.first
          link_string = root_url + text_snippet['href']
          link_list << Result.new(nil, nil, URI(root_url + text_snippet['href']))
          link_count += 1
          page_text << "#{link_count}) Link: \e[4m#{text_snippet.content}\e[0m (#{link_string})\n"
        else
          page_text << "INCOMPATIBLE LINK\n"
        end
      else
        page_text << "#{text_snippet.name} | #{text_snippet.content}\n"
      end
    end
    PageData.new(page_text.join(''), link_list)
  end
end
