class RakutenBookDisplay
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def run
    {
      title: title,
      image_url: image_url,
      published_date: published_date,
      isbn: isbn,
      price: price,
      rakuten_review_score: review_score,
      rakuten_review_count: review_count,
      rakuten_link: link,
      item_caption: item_caption,
      amazon_review_score: amazon_review_score,
      amazon_review_count: amazon_review_count,
      amazon_link: amazon_link,
      page_count: page_count,
    }
  end

  private

  def title
    item['title']
  end

  def image_url
    item['mediumImageUrl'] || amazon_book&.image_url

  end

  def published_date
    item['salesDate']
  end

  def isbn
    @isbn ||= item['isbn']
  end

  def price
    item['itemPrice']
  end

  def review_score
    return if review_count.zero?

    item['reviewAverage'].to_f
  end

  def review_count
    @rakuten_review_count ||= item['reviewCount']
  end

  def link
    item['affiliateUrl']
  end

  def item_caption
    item['itemCaption'].truncate(50)
  end

  def amazon_book
    return @amazon_book if defined? @amazon_book

    @amazon_book = AmazonBook.find_by(isbn: isbn)
  end

  def amazon_review_score
    amazon_book&.review_score
  end

  def amazon_review_count
    amazon_book&.review_count
  end

  def amazon_link
    amazon_book&.link
  end

  def page_count
    amazon_book&.page_count
  end
end