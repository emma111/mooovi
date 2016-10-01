class RankingController < ApplicationController
  layout 'review_site'
  before_action :ranking
  def ranking
      product_ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys #=> product_idカラムの値が同じレコードのまとまりを作る.さらに、countメソッドにより、まとまりのproduct_idカラムの値をキー、同カラムの同じ値のレコードの数をバリューとするセットが5つ入ったハッシュを生成します。最後に、ハッシュのキーのみの配列を返してくれるkeysメソッドを使用し、最終的にレビューの数が多いproduct上位5件のidが順番に並んだ配列を取得しています。
      @ranking = product_ids.map { |id| Product.find(id) }
      #Product.find(id)の部分が特定の処理にあたります。idにはproduct_idsの中身一つ一つ、つまりproductsテーブルのレコードのidが入ります。つまりこの処理は、ただのid番号だったものをproductsテーブルのレコードのインスタンスに変換するというものです。結果、左辺である@rankingにはレビューの数が多いproductsテーブルのレコード上位5件が順番に並んだ配列が代入されます。
end
end
