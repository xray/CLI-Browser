class WebItem
  attr_reader :content

  def initialize(content)
    @content = content
  end
end

class Link < WebItem
  attr_reader :url

  def initialize(content, url)
    super(content)
    @url = url
  end
end

class SearchResult < Link
  attr_reader :description

  def initialize(content, url, description)
    super(content, url)
    @description = description
  end
end

class PageContent < WebItem
  attr_reader :type

  def initialize(content, type)
    super(content)
    @type = type
  end
end