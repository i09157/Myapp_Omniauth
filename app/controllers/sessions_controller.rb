#encoding: utf-8
class SessionsController < ApplicationController
 def callback
    #omniauth.auth環境変数を取得
    auth = request.env["omniauth.auth"]
    #omniuserモデルを検索
    omniuser = Omniuser.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if omniuser
       user = User.find_by_omniuser_id(omniuser.id)
       if user
         session[:user_id] = omniuser.id
         redirect_to root_url, :notice => "サインインしました。"
       else
         #②userが存在しない = Userモデルにレコードがない = Devise認証はまだ => ユーザ登録ページへ
         redirect_to new_user_registration_path, :notice => "#{auth["info"]["nickname"]}さんの#{auth["provider"]}アカウントとはすでに接続済みです。メンバー登録に必要なメールアドレスとパスワードを入力してください。"
       end
    else
         # Omniuserモデルに:providerと:uidが無い場合（外部認証していない）、:provider,:uidを保存してから、新規登録ページへ遷移させる
         Omniuser.create_with_omniauth(auth)
         session[:tmp_uid] = auth["uid"]
         redirect_to new_user_registration_path, :notice =>
         "#{auth["info"]["nickname"]}さんの#{auth["provider"]}アカウントと接続しました。メンバー登録に必要なメールアドレスとパスワードを入力してください。"
    end

  end
  def destroy
    reset_session
    redirect_to root_url, :notice => "サインアウトしました。"

  end
end
