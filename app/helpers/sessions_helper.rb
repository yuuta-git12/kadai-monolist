module SessionsHelper
    def current_user
        #現在ログインしているユーザーを取得するメソッド
        #@current_userに既に現在のログインユーザが代入されていたら何もせず
        #nil空の状態の場合はログインユーザを取得して@current_userに代入する
        
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
        #ユーザがログインしていればtrueを返し、ログインしていなければfalseを返す
        #current_userが存在する場合[!!true]⇨[true]
        #current_userが存在しない場合[!!nil]⇨[!true]⇨[false]
    def logged_in?
        !!current_user
    end
end
