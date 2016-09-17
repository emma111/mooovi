class ProductsController < RankingController
  def index
    @products = Product.limit(20).order('id ASC')# productsテーブルから最新順に作品を２０件取得する,モデル名.limit(取得件数)
  end

  def show
    # productsテーブルから該当するidの作品情報を取得し@productの変数へ代入する処理を書いて下さい
    @product = Product.find(params[:id])#コントローラーでインスタンス変数は定義してしまう。→ビューに渡す。作品idはそれぞれ固有のidが振られており、idが同じ作品は存在しないので、該当のidの情報を1件だけ取得するメソッドであるfindメソッドに作品idを渡せば作品情報を取得することができる
  end

  def search
    # 検索フォームのキーワードをあいまい検索して、productsテーブルから20件の作品情報を取得する
     @products = Product.where('title LIKE(?)', "%#{params[:keyword]}%").limit(20)
  end
end


