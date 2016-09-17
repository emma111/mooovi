class Product < ActiveRecord::Base
  has_many :reviews
  #has_many :所有するモデル名(複数形)
end
