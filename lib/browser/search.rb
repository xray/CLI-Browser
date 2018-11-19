class Search
  attr_reader :provider

  def initialize(provider)
    @provider = provider
  end

  def results(term)
    provider.results(term)
  end
end
