require 'uri'
require 'link'

# Generates DuckDuckGo search links based on a serach query
class LinkGenerator
  def initialize(link = Link)
    @link = link
  end

  def get_link(query)
    query_encoded = URI.encode_www_form([['q', query]])
    @link.new(link: "https://duckduckgo.com/html/?#{query_encoded}")
  end

  def next_page(given_link)
    next_page_number = given_link.page + 1
    next_page_value = determine_page_number_value(next_page_number)
    next_page_link = "#{given_link.original_link}&s=#{next_page_value}"\
                     "&v=l&o=json&dc=#{next_page_value}&api=%2Fd.js&kl=us-en"
    @link.new(
      link: next_page_link,
      original_link: given_link.original_link,
      page: next_page_number,
      history: given_link.history.push(given_link)
    )
  end

  def previous_page(given_link)
    @link.new(
      link: given_link.history.last.link,
      original_link: given_link.original_link,
      page: given_link.page - 1,
      history: given_link.history.push(given_link)
    )
  end

  def determine_page_number_value(page_number)
    if page_number == 1
      false
    else
      (30 + ((page_number - 2) * 50)).to_s
    end
  end
end
