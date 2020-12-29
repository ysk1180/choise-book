class AmazonGetItem
  attr_reader :isbn

  def initialize(isbn)
    @isbn = isbn
  end

  def run
    amazon_book = AmazonBook.find_by(isbn: isbn)
    return amazon_book.display if amazon_book

    amazon_book_display = AmazonBookDisplay.new(item, isbn_10)
    amazon_book = AmazonBook.create_with(amazon_book_display, isbn)
    amazon_book.display
  end

  def item
    @item ||= request.dig('ItemsResult', 'Items')&.first
  end

  private

  def client
    @client ||= Vacuum.new(marketplace: 'JP',
                           access_key: Rails.application.credentials.aws[:api_access_key],
                           secret_key: Rails.application.credentials.aws[:api_secret_key],
                           partner_tag: Rails.application.credentials.aws[:associate_tag])
  end

  def request
    client.get_items(item_ids: [isbn_10],
                     # browser_node_id: 466298,
                     # merchant: 'Amazon',
                     resources: [
                       'ItemInfo.Title',
                       'Images.Primary.Medium',
                       'ItemInfo.ContentInfo',
                     ]).to_h
  end

  # Amazonの仕様でISBN10桁しかダメだった。変換の参考にしたサイト：https://qiita.com/jnchito/items/b8be26ce87b56c9341ae
  def isbn_10
    @isbn_10 ||= (body = isbn[3..-2])
        .each_char.with_index
        .inject(0) { |sum, (c, i)| sum + c.to_i * (10 - i) }
        .then { |sum| 11 - sum % 11 }
        .then { |raw_digit| { 10 => 'X', 11 => 0 }[raw_digit] || raw_digit }
        .then { |digit| "#{body}#{digit}" }
  end
end