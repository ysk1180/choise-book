class BooksController < ApplicationController
  def search
    return [].to_json if params[:q].blank?

    SearchWord.create(word: params[:q])

    books = RakutenSearch.new(params[:q]).run
    render json: books
  end

  def show
    return {}.to_json if params[:isbn].blank?

    book = AmazonGetItem.new(params[:isbn]).run
    render json: book
  end
end
