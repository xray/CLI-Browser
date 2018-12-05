require 'browser/page_item'

RSpec.describe PageItem do
  it 'creates a web item with content' do
    content = 'Fake Content'

    test_web_item = PageItem.new(content)

    expect(test_web_item.content).to eq content
  end
end

RSpec.describe Link do
  it 'creates a link with content and a url' do
    content = 'Link to Google'
    url = URI("https://www.google.com")

    test_link = Link.new(content, url)

    expect(test_link.content).to eq content
    expect(test_link.url).to eq url
  end
end

RSpec.describe SearchResult do
  it 'creates a search result with content, url, and description' do
    content = 'Apple | Wikipedia'
    url = URI('https://www.wikipedia.com/wiki/Apple')
    description = 'The apple is a deciduous tree, generally standing 6 to 15 ' \
                  'ft (1.8 to 4.6 m) tall in cultivation and up to 30 ft ' \
                  '(9.1 m) in the wild. When cultivated, the size, shape ' \
                  'and branch density are determined by rootstock' \
                  'selection and trimming method.'

    test_result = SearchResult.new(content, url, description)

    expect(test_result.content).to eq content
    expect(test_result.url).to eq url
    expect(test_result.description).to eq description
  end
end

RSpec.describe PageContent do
  it 'creates a general piece of page content with content and a type' do
    content = 'a representation of a short paragraph'
    type = 'p'

    test_page_content = PageContent.new(content, type)

    expect(test_page_content.content).to eq content
    expect(test_page_content.type).to eq type
  end
end