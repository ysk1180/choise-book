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

  def self.create_with(amazon_book_display, isbn)
    create(
      isbn: isbn,
      title: amazon_book_display.title,
      page_count: amazon_book_display.page_count,
      image_url: amazon_book_display.image_url,
      review_score: amazon_book_display.review_score,
      review_count: amazon_book_display.review_count,
      link: amazon_book_display.link,
    )
  end
end