namespace 'delete' do
  desc 'DBで保持している古くなったAmazonのレビュー情報を削除する日次バッチ'
  task old_amazon_records: :environment do
    now = Time.current
    last_month = now.prev_month # 1ヶ月経っているレコードを削除する

    AmazonBook.find_each do |book|
      next if book.created_at > last_month # 最近のデータだったらそのまま

      book.destroy
    end
  end
end
