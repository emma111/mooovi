class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
　has_attached_file :avatar,
                      styles:  { medium: "300x300#", thumb: "100x100#" }
                      #aサイズを指定するための属性はstylesです。stylesではどのような種類の画像をどの大きさで保存するか指定。vatarカラムにアップ可能な画像の大きさを指定
  validates_attachment_content_type :avatar,
                                      content_type: ["image/jpg","image/jpeg","image/png"] #avatarカラムにアップ可能な画像ファイルを指定
end

end
