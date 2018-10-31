class Link
  attr_reader :link, :page

  def initialize(attributes={})
    @link = attributes.fetch(:link, nil)
    @page = attributes.fetch(:page, 1)
  end
end