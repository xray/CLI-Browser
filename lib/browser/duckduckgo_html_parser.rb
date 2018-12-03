require 'nokogiri'
require 'cgi'

Result = Struct.new(:title, :description, :url )

class DuckDuckGoHTMLParser
  def parse(body)
    results_list = []
    doc = Nokogiri::HTML(body)
    doc.css('div.result__body').each do |raw_result|
      link = raw_result.css('a.result__a')[0]
      res_title = link.content.sub("\u200E", '')
      res_description = raw_result.css('a.result__snippet')[0].content
      res_url = URI(CGI.unescape(link['href']).gsub(%r{\/l\/\?kh=-1&uddg=}, ''))
      results_list.push(Result.new(res_title, res_description, res_url))
    end
    results_list
  end
end
