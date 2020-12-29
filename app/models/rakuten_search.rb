class RakutenSearch
  attr_reader :keyword

  def initialize(keyword)
    @keyword = keyword
  end

  def run
    request.map { |item| RakutenBookDisplay.new(item).run }
  end

  private

  def request
    RakutenWebService::Books::Book.search(
      title: keyword,
      hits: 20,
    )
  end
end