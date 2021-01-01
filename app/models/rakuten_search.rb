class RakutenSearch
  attr_reader :keyword, :page

  def initialize(keyword, page)
    @keyword = keyword
    @page = page
  end

  def run
    books = request.map { |item| RakutenBookDisplay.new(item).run }
    total_count = request.response.count
    has_next_page = request.next_page?
    {
      total_count: total_count,
      has_next_page: has_next_page,
      books: books
    }
  end

  private

  def request
    @request ||= RakutenWebService::Books::Book.search(
      title: keyword,
      hits: 20,
      page: page,
      # books_genre_id: '001012010001', # GenreLevel:4の電気工学/別ジャンルにも技術書が含まれており、複数指定はできなかった..
    )
  end
end