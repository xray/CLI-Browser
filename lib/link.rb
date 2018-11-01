class Link
  attr_reader :link, :original_link, :page, :history

  def initialize(attributes = {})
    @link = attributes.fetch(:link, nil)
    @original_link = attributes.fetch(:original_link, @link)
    @page = attributes.fetch(:page, 1)
    @history = attributes.fetch(:history, [])
  end
end
