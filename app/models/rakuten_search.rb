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
      # books_genre_id: '001012010001', # GenreLevel:4の電気工学/別ジャンルにも技術書が含まれており、複数指定はできなかった..
    )
  end
end