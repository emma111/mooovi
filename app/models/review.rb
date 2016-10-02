class Review < ActiveRecord::Base
belongs_to :product #1つのモデルに所属する側のモデルにはbelongs_toを記述.[belongs_to :所属するモデル名(単数形)
belongs_to :use

end

