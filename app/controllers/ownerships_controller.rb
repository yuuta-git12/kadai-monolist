class OwnershipsController < ApplicationController
  def create
    #Item.find_byでcode列から[:item_code]と同じ数字のItemを探し,
    #該当するItemがない場合は,Item.newとして新規に作成する
    @item = Item.find_or_initialize_by(code: params[:item_code])
    
    #@itemが保存されているかどうかを判断 保存されていればtrue 保存されていなければfalse
    #@itemが保存されていなければunless以下の処理を実行する
    unless @item.persisted?
      #@itemが保存されていない場合、先に@itemを保存する
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
    
      @item = Item.new(read(results.first)) #read()はitems_controllerのメソッド
      @item.save
    end
    
    #Want関係として保存
    if params[:type] == 'Want'
      current_user.want(@item)
      flash[:success] = '商品をWantしました。'
    end
    
    #直前のページにリダイレクトするが、ページがない場合はrootにリダイレクトする
    redirect_back(fallback_location: root_path)
    
  end

  def destroy
    @item = Item.find(params[:item_id])
    
    if params[:type] == 'Want'
      current_user.unwant(@item)
      flash[:success] = '商品のWantを解除しました。'
    end
    
    #直前のページにリダイレクトするが、ページがない場合はrootにリダイレクトする
    redirect_back(fallback_location: root_path)
  end
end
