class Omniuser < ActiveRecord::Base
  #attr_accessible :image, :name, :nickname, :provider, :token, :uid
  belongs_to :user
  def self.create_with_omniauth(auth)
    create! do |omniuser|
      omniuser.provider = auth["provider"]
      omniuser.uid = auth["uid"]
      omniuser.name = auth["info"]["name"]
      omniuser.nickname = auth["info"]["nickname"]
      omniuser.image = auth["extra"]["raw_info"]["avatar_url"]
      omniuser.token = auth["credentials"]["token"]
    end
  end
end
