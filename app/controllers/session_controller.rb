class SessionController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email,password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  
  private
  
  def login(email,password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password) #emailとパスワードの組み合わせが正しいか判断
      #ログイン成功
      session[:user_id] = @user.id
      return true #trueを返すのでdef createでif文にtrueが入る
    else
      #ログイン失敗
      return false
    end
  end
end
