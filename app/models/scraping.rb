class Scraping
  def self.movie_urls

    links = []
    #まず全体からそれぞれの①linksという配列の空枠を作る
     agent = Mechanize.new  #②Mechanizeクラスのインスタンスを生成する
     next_url = ""

     while true
        current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
        #③映画の全体ページのURLを取得
        elements = current_page.search('.entry-title a')
        #④全体ページから映画20件の個別URLのタグを取得
        elements.each do |ele|
          links << ele.get_attribute('href')
        end
        #⑤個別URLのタグからhref要素を取り出し、links配列に格納する
        next_link = current_page.at('.pagination .next a')
        break unless next_link
        next_url = next_link.get_attribute('href')
     end

        links.each do |link|
          get_product('http://review-movie.herokuapp.com/' + link)
         #⑥get_productを実行する際にリンクを引数として渡す
        end
  end

  def self.get_product(link)
        agent = Mechanize.new
        #⑦Mechanizeクラスのインスタンスを生成する
         page = agent.get(link)
        #⑧映画の個別ページのURLを取得
        title = page.at('.entry-title ').inner_text
        #⑨inner_textメソッドを利用し映画のタイトルを取得
        image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
        #①⓪image_urlがあるsrc要素のみを取り出す,if 条件と加えると、条件がtrueの時にのみ左の文を実行する
        director = page.at('.director span').inner_text if page.at('.director span')
       detail = page.at('.entry-content p').inner_text if page.at('.entry-content p')
       open_date = page.at('.date span').inner_text if page.at('.date span')

         product = Product.where(title: title, image_url: image_url).first_or_initialize
         #whereメソッドを使用して引数の条件(titleカラムに変数titleの値が一致とimage_urlカラムに変数image_urlの値が一致という二つの条件)に一致するレコードを検索します。条件に一致するレコードがあった場合はそのレコードを取得し、なかった場合はtitleカラムに変数titleの値とimage_urlカラムに変数image_urlの値が代入された新しいレコードを生成するような処理をする
         product.image_url = image_url #取得したインスタンスのカラムを更新するにはインスタンス.カラム名 = 値という記述方法を使う
         product.director = director
        product.open_date = open_date

        product.save
        #①①newメソッド、saveメソッドを使い、 スクレイピングした「映画タイトル」と「作品画像のURL」をproductsテーブルに保存
      end
    end