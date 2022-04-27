class AmazonBook < ApplicationRecord
  def display
    {
      amazon_image_url: image_url,
      page_count: page_count,
      amazon_review_score: review_score,
      amazon_review_count: review_count,
      amazon_link: link,
    }
  end

  def save_with(amazon_book_display)
    update!( # 元々保存されてないデータでもupdate!でうまくいったのでこうしている(中でsave!を呼び出していた)
      title: amazon_book_display.title,
      page_count: amazon_book_display.page_count,
      image_url: amazon_book_display.image_url,
      review_score: amazon_book_display.review_score,
      review_count: amazon_book_display.review_count,
      link: amazon_book_display.link,
    )
    self
  end
end