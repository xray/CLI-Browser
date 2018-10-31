# DuckDuckGo Info
# Search Prefix: https://duckduckgo.com/html/?q=
# Search Query: URL Encoded User Input
# Page Selector: 30 (Starting Point), Incremented by 50 for each page
# Search Suffix - Part 1: &s=(Page Selector)
# Search Suffix - Part 2: &v=l&o=json
# Search Suffix - Part 3: &dc=(Page Selector)
# Search Suffix - Part 4: &api=%2Fd.js&kl=us-en
# Search Suffix - (Part 1) + (Part 2) + (Part 3) + (Part 4)
# Final Query: (Search Prefix) + (Search Query) + (Search Suffix)

require 'uri'
require 'link'

class LinkGenerator
  def initialize(link=Link)
    @link = link
  end

  def get_link(query)
    query_no_spaces = query.gsub(/[\s]/, '+')
    query_encoded = URI.encode(query_no_spaces)
    return @link.new({link: "https://duckduckgo.com/html/?q=#{query_encoded}"})
  end
end